#!/usr/bin/env bash
set -e

main() {
    dir="$( cd "$(dirname "$0")" && pwd )"
    echo "Please wait..."
    validate_state
    clean_up
    echo "State ok"
    state=""
    while sleep 1; do
        if ! changes_exist "$dir" >/dev/null; then
            continue
        fi
        if changes_exist "$dir/test/"; then
            git add "$dir/test/"
            commit 'Add test'
            state="red"
        fi
        if "$dir"/test/test.sh; then
            clean_up
            git add -A "$dir"
            commit 'TCR'
            state=""
        else
            git reset --hard HEAD
        fi
    done
}

validate_state() {
    true \
    && ! modified_files "$dir" \
    && ! untracked_files "$dir" \
    && "$dir"/test/test.sh >/dev/null
}

commit() {
    amend="$([ "$state" = "red" ] && echo '--amend' || echo '')"
    git commit $amend -m "$1"
}

clean_up() {
    if grep -q org.junit.jupiter \
        "$dir/test/src/test/java/com/github/tingstad/junit4to5/"*.java
        then
        git checkout -- "$dir/test/src/"
    fi
}

changes_exist() {
    untracked_files "$1" \
    || modified_files "$1"
}

modified_files() {
    git ls-files --modified --deleted --error-unmatch "$1" 2>/dev/null \
    || git diff --name-only --cached | grep .
}

untracked_files() {
    git ls-files --others --exclude-standard --error-unmatch "$1" 2>/dev/null
}

main "$@"

