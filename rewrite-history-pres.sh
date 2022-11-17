#!/bin/bash
########################
# include the magic
# https://github.com/paxtonhare/demo-magic
########################
. demo-magic.sh
cd workspace
rm -rf .git fraises.ml fondant.gr luminyen-poulet.fr luminyen-omelette.no test_fail.sh test_success.sh

########################
# amend
# - amend -m
# - amend tout court
# reflog
# - reflog sur un commit
# - reflog sur une branche
# - rebase
# - reflog sur un rebase
# rebase interactif
# - rename
# - drop
# - squash/fixup
# - edit
# - exec
########################

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
    DEMO_PROMPT="${PREFIX_PROMPT} git:(${LIGHT_RED}${BRANCH:=detached}${PURPLE})${NC} ➤ "
}

DEMO_PROMPT="${PREFIX_PROMPT} "

# hide the evidence
clear

pe "git init --quiet"
pep "git branch -m main"                                         # optionnel
pep "export GIT_PAGER=\"less -F\""                               # optionnel cat/more

pep "git add .gitignore"                                         # permet d'avoir un workspace clean pendant la demo
pep "git commit -m \":tada: Je me reveille à Paris\""
pep "git commit --amend --allow-empty -m \"Je me reveille à Marseille\""
pep "git commit --amend --allow-empty"                           # message: "Je me reveille aux Goudes!
pep "git log --pretty=oneline --abbrev-commit"
pep "git log --walk-reflogs --pretty=oneline --abbrev-commit"    # on affiche ici les reflogs
pep "git reflog"                                                 # même résultat
pep "git reset HEAD@{1}"
pep "git show HEAD~0"
# on peut voir le reflog par branche
pep "git switch -C preparer-mon-sac"
pep "git commit --allow-empty -m \"je prends mon sac\""
pep "git commit --allow-empty -m \"je prends mes lunettes\""
pep "git commit --allow-empty -m \"je prends ma serviette de plage\""
pep "git reflog"
pep "git reflog show preparer-mon-sac"
pep "git switch main"
pep "git commit --allow-empty -m \"je sors du lit\""
pep "git switch preparer-mon-sac"
pep "git rebase main"
pep "git reflog"
pep "git reset HEAD@{12}"
git switch -c "arrivee-dans-les-callanques" main
# rebase interactif!
pep "git commit --allow-empty -m \"je prends le bus 22\""
pep "git commit --allow-empty -m \"je sors de chez moi\""
pep "git commit --allow-empty -m \"je descend du bus\""
pep "git commit --allow-empty -m \"je prends un sandwich\""
pep "touch fraises.ml && git add fraises.ml"
pep "git commit -m \"je prends un milk-shake\""
pep "touch fondant.gr && git add fondant.gr"
pep "git commit -m \"je prends un petit dessert\""
pep "git log --pretty=oneline --abbrev-commit"
pep "git rebase --interactive HEAD~5 --autostash"
# deplace "je sors de chez moi en premier!"
# reword je prends le bus 22 => je prends le bus 21
pep "touch luminyen-poulet.fr && git add luminyen-poulet.fr"
pep "git commit -m \"ajout du sandwich poulet\""
pep "git rebase --interactive main"
# squash "ajout du sandwich" sur "je prends un sandwich"
# drop milk-shake
pep "mv luminyen-poulet.fr luminyen-omelette.no && git add luminyen-*"
pep "git commit --fixup HEAD~1"
pep "git rebase --interactive main --autosquash"
# fixup "remplace poulet par omelette" sur "je prends un sandwich"
pep "git rebase --interactive main"
#  edit sur le premier
#  add exec ./test_fail.sh sur "je prends le bus"
#  add exec ./test_success.sh sur "je descend du bus"
pep "cp ../test* . && chmod +x test* && git add test*"
pep "git commit -m \"CI Ready\""
# regarder le petit commit en plus!
pep "git rebase --continue"
pep "git rebase --edit-todo"
pep "git rebase --continue"
pep "echo \"allé, on débrief\""

pep "echo bye"
