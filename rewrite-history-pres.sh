#!/bin/bash
########################
# include the magic
# https://github.com/paxtonhare/demo-magic
########################
. demo-magic.sh
rm -Rf workspace
mkdir workspace && cd workspace

YELLOW='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
RED='\033[0;34m'
LIGHT_RED='\033[0;33m'
NC='\033[0m' # No Color
DEMO_PROMPT=""

function pep(){
    prompt
    pe "$@"
}

function prompt () {
    BRANCH=$(git branch --show-current)
    DEMO_PROMPT="➜ ${CYAN}wakeupInGit${PURPLE} git:(${LIGHT_RED}${BRANCH:=detached}${PURPLE})${NC} ✗ "
}

# hide the evidence
clear

