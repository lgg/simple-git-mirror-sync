#!/usr/bin/env bash
function usage
{
    printf "\n"
    printf "check usage in gitlab repo: https://gitlab.com/neuro-core/common/simple-git-mirror-sync\n"
    printf "\n"
    printf "./sync.sh sourceRepo targetRepo\n"
    printf "\n"
    printf "or run with config: ./sync.sh -c"
    printf "\n"
    printf "!!! only ssh@git url supported !!!\n"
    printf "\n"
}

function run
{
    source="$1"
    target="$2"
    # parse repo folder name
    repoName="${source##*/}"
    repoName="${repoName/.git/}"

    echo "Syncing $source to $target with directory: $repoName"

    # check if directory exists and delete folder
    [[ -d "./${repoName}" ]] && echo "Clearing folder" && rm -rf ${repoName}

    # clone repo to folderName
    echo "Cloning to ${repoName}"
    git clone ${source} ${repoName}
    cd ${repoName}
    git fetch --all

    # get all branches
    for b in `git branch -r | grep -v -- '->' | grep origin | awk '{print $1}'`; do git checkout ${b#*/}; done

    # add remote target
    git remote add target ${target}
    git config --get push.default

    # sync master to set it as default branch in remote repo
    git checkout master
    git push -u target master

    # sync all branches to target
    for b in `git branch | sed "s/*//"`; do git push -u target $b; done

    echo "Synced"

    # clear folder
    echo "Clearing folder"
    cd ..
    rm -rf ${repoName}
}

if [[ -z "$1" && -z "$2" ]]; then
    printf "No arguments\n"
    usage;
    exit;
fi

mkdir -p sync
cd sync

if [[ "$1" = "-c" ]]; then
    printf "Running with config\n"
    while IFS= read -r line; do
        source=`echo ${line} | awk '{print $1}'`
        target=`echo ${line} | awk '{print $2}'`

        run ${source} ${target}
    done < ../config.conf
else
    if [[ -z "$2" ]]; then
        printf "You missed target repo\n"
        usage;
        exit;
    fi
    run $1 $2;
fi
