#!/bin/bash

WORKSPACE=rewrite-workspace
rm -rf ../${WORKSPACE}/
mkdir ../${WORKSPACE}
cp -R ./workspace_files/.vscode ../${WORKSPACE}/.vscode
cp -R ./workspace_files/.gitignore ../${WORKSPACE}/.gitignore
cp -R ./workspace_files/tests ../${WORKSPACE}/tests
cp -R ./rewrite-history-pres.sh ../${WORKSPACE}/start.sh
chmod +x ../${WORKSPACE}/start.sh
cp -R ./demo-magic.sh ../${WORKSPACE}/
code ../${WORKSPACE}
