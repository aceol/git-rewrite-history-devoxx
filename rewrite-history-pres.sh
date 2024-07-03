#!/bin/bash
########################
# include the magic
# https://github.com/paxtonhare/demo-magic
########################
. demo-magic.sh

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
PREFIX_PROMPT="➜ ${CYAN}hello@TZ${PURPLE}"

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
pep "export GIT_PAGER=\"less -F\""                               # optionnel cat/more

pep "git add .gitignore"                                         # permet d'avoir un workspace clean pendant la demo
pep "git commit -m \":tada: Je me reveille à Paris\""
pep "git commit --amend --allow-empty -m \"Je me reveille à Nansouty\""
pep "git commit --amend --allow-empty"                           # message: "Je me reveille aux Goudes!
pep "git log --pretty=oneline --abbrev-commit"
pep "git log --walk-reflogs --pretty=oneline --abbrev-commit"    # on affiche ici les reflogs
pep "git reflog"                                                 # même résultat
pep "git reset HEAD@{1}"
pep "git show HEAD~0"
# on peut voir le reflog par branche
pep "git switch -C preparer-mon-sac"
pep "git commit --allow-empty -m \"je prends mon sac\""
pep "git commit --allow-empty -m \"je prends mon ordi\""
pep "git commit --allow-empty -m \"je prends mon chargeur\""
pep "git reflog"
pep "git reflog show preparer-mon-sac"
pep "git switch main"
pep "git commit --allow-empty -m \"je sors du lit\""
pep "git switch preparer-mon-sac"
pep "git rebase main"
pep "git reflog"
pep "git switch -c \"trajets\""
# rebase interactif!
pep "git commit --allow-empty -m \"je passe devant les cacas\""
pep "git commit --allow-empty -m \"je passe devant le miroir d'eau\""
pep "git commit --allow-empty -m \"je passe par saint michel\""
pep "git commit --allow-empty -m \"je suis devant pompom\""
pep "touch cafe.ml && git add cafe.ml"
pep "git commit -m \"je prends un croissant\""
pep "touch croissant.gr && git add croissant.gr"
pep "git commit -m \"je prends un petit jus d'orange x\""
pep "git log --pretty=oneline --abbrev-commit"
pep "git rebase --interactive HEAD~7 --autostash"
# reword je passe devant les cacas => je passe devant les capus
# deplace "je passe par saint michel 2nd!"
pep "touch mollets-de-feu.fr && git add mollets-de-feu.fr"
pep "git commit -m \"On monte les escaliers\""
pep "git commit --allow-empty -m \"On monte le 2e etage des escaliers\""
pep "git commit --allow-empty -m \"On monte le 3e etage des escaliers\""
pep "git commit --allow-empty -m \"On fait une pause\""
pep "git commit --allow-empty -m \"On monte le 4e etage des escaliers\""
pep "git rebase --interactive main"
# squash "On monte le Xe etage des escaliers" sur "On monte les escaliers"
# drop On fait une pause
pep "mv mollets-de-feu.fr mollets-de-glace.fr && git add mollets-de-glace.fr && git rm mollets-de-feu.fr"
pep "git commit --fixup HEAD~2"
pep "git rebase --interactive main --autosquash"
# fixup "remplace mollets-de-feu" sur "mollets-de-glace"
pep "git rebase --interactive main --exec ./tests.sh"
#  edit sur le premier
#  add exec ./tests/ok.sh sur "je prends le bus"
#  add exec ./tests/ko.sh sur "je descend du bus"
pep "cp ./tests/ko.sh ./tests.sh"
pep "chmod +x ./tests.sh && git add ./tests.sh"
pep "git commit -m \"CI Ready\""
# regarder le petit commit en plus!
pep "git rebase --continue"
pep "git rebase --edit-todo"
pep "cp ./tests/ok.sh ./tests.sh"
pep "chmod +x ./tests.sh && git add ./tests.sh"
pep "git commit --amend"
pep "git rebase --continue"
pep "echo \"allé, on débrief\""

pep "echo bye"

p ""