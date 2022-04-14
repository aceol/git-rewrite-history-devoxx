#!/bin/bash
########################
# include the magic
# https://github.com/paxtonhare/demo-magic
########################
. demo-magic.sh
cd workspace
rm -rf .git glasses sugar slippers milk

GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
LIGHT_RED='\033[0;33m'
NC='\033[0m' # No Color
DEMO_PROMPT=""
PREFIX_PROMPT="➜ ${CYAN}wakeupInGit${PURPLE}"

function pep(){
    prompt
    pe "$@"
}

function prompt () {
    BRANCH=$(git branch --show-current)
    DEMO_PROMPT="${PREFIX_PROMPT} git:(${LIGHT_RED}${BRANCH:=detached}${PURPLE})${NC} ✗ "
}

DEMO_PROMPT="${PREFIX_PROMPT} "

# hide the evidence
clear

pe "git init --quiet"
pep "git branch -m main"                                         # optionnel
pep "export GIT_PAGER=cat"                                       # optionnel

pep "git add .gitignore"                                         # permet d'avoir un workspace clean pendant la demo
pep "git commit -m \":tada: Reveil en fanfare (first)\""
pep "git commit --allow-empty -m \"Je me leve!\""
pep "touch glasses && git add glasses"
pep "git commit --amend "                                        # message: "Je me leve et je vois bien!
pep "git show HEAD~0"

pep "git commit --allow-empty -m \"Je pars à la cuisine\""
pep "echo \"Guybrush Threepwood\" > slippers"
pep "git add slippers"
pep "git commit --amend -m \"Je pars à la cuisine en chaussons\""
pep "git show HEAD~0"

pep "echo \"Purple Tentacle\" > slippers"
pep "git commit -a --amend --no-edit"
pep "git show HEAD~0"
pep "git show HEAD~1"

pep "git log --walk-reflogs --pretty=oneline --abbrev-commit"
pep "git reflog"                                               # même résultat

pep "git show HEAD@{0}"
pep "git show HEAD@{1}"
pep "git reset --soft HEAD@{1}"
pep "git show HEAD~0"
pep "cat slippers"
pep "git reset --hard HEAD@{0}"

# on peut voir le reflog par branche
pep "git switch -C dejeuner"
pep "git commit --allow-empty -m \"Un commit de p'tit dejeuner!\""
pep "git reflog"

pep "git reflog show dejeuner"
pep "git reflog show main"                                     # constater qu'on a pas le reflog de la branche dejeuner
pep "git reflog show origin/main"                              # constater les pushs vers la branche (mais pas ici, on a pas de remote!)
pep "git reset HEAD^"

# rebase interactif!
pep "git commit --allow-empty -m \"Je me sert un café\""
pep "git commit --allow-empty -m \"Je bois mon café\""
pep "git commit --allow-empty -m \"Je met du sucre\""
pep "git commit --allow-empty -m \"Je prends une tasse\""
pep "git commit --allow-empty -m \"Je deguste en défilant slack\""

pep "git log --pretty=oneline --abbrev-commit"
pep "git rebase --interactive HEAD~4"
# reword Je prends une tasse => au debut + rename mug
# edit Je met du sucre ⬇️
pep "touch sugar && git add sugar"
pep "git rebase --continue"

pep "git log --pretty=oneline --abbrev-commit"
pep "touch milk && git add milk"
pep "git commit -m \"avec du lait\""

pep "git rebase --interactive main"
# squash je me sert un cafe avec du sucre
# fixup avec du lait => je bois mon café

pep "echo \"aux amandes\" > milk"
pep "git show HEAD~1"
pep "git commit -a --fixup HEAD~1"
pep "git rebase -i main"                                         # on ne fait rien ici (on le fera via l'autosquash)

pep "git rebase -i main --autosquash"
pep "git rebase -i main --exec ls"
pep "git reflog --date=relative"

pep "echo bye"
