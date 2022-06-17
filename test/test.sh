#!/usr/bin/env bash
set -e

main() {
    dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" >/dev/null 2>&1 ; pwd -P)

    gnuver=$(sed --version 2>/dev/null | grep GNU | grep -E -o '[0-9]+\.[0-9]+' || true)
    if [ -n "$gnuver" ] && less_than_4_2 $gnuver; then
        arg="-r"
    else
        arg="-E"
    fi

    for opt; do
        case "$opt" in
            txt)
                run_txt "$dir" "$arg" ;;
            mvn)
                run_mvn "$dir" "$arg" ;;
            *)
                echo "Unknown arg: $opt" >&2
                exit 1 ;;
        esac
    done

    echo "All OK!"
}

run_txt() { dir="$1" arg="$2"
    diff "$dir/expected.txt" <(sed $arg -f "$dir/../junit4-to-5.sed" "$dir/test.txt")
}

run_mvn() { dir="$1" arg="$2"
    { results4=$(mvn_test "$dir/junit4.pom.xml"); } 4>&1
    find "$dir/src" -name \*.java -exec sed $arg -i.bak -f "$dir/../junit4-to-5.sed" {} \; \
        -exec rm {}.bak \;
    { results5=$(mvn_test "$dir/junit5.pom.xml"); } 4>&1
    diff <(echo "$results4") <(echo "$results5")
}

mvn_test() {
    local file="$1"
    mvn -B -f "$file" clean test \
        | tee /dev/fd/4 \
        | grep_results
    return ${PIPESTATUS[0]}
}

grep_results() {
    sed -n '/Results:/,/Tests run:/p'
}

less_than_4_2() {
    local ver="$1"
    if [ -n "$ver" ] && [ ${ver%.*} -lt 4 -o ${ver%.*} -eq 4 -a ${ver#*.} -lt 2 ]; then
        true
    else
        false
    fi
}

less_than_4_2 "1.17"
less_than_4_2 "3.02"
less_than_4_2 "3.2"
less_than_4_2 "4.1"
! less_than_4_2 "4.2" || exit 1
! less_than_4_2 "4.4" || exit 1
! less_than_4_2 "30.0" || exit 1

if [ -z "$BASH_VERSION" ]; then
    >&2 echo "Bash is required"
    exit 1
fi

if [ $# -gt 0 ]; then
    main "$@"
else
    main txt mvn
fi

