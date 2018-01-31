#! /bin/bash
set -euo pipefail

function _require()
{
  if ! command -v $1 &> /dev/null; then
    echo "This program depends on $1 to be installed"
    echo "You can use your package manager (eg brew install $1) to install it"
    exit 1
  fi
}

function setup()
{
  # Make sure dependencies are installed
  _require "jq"
  _require "curl"
  _require "git"

  # Set the core.hooksPath in git
  if ! git config --global --get core.hooksPath; then
    echo "There is no global git hook path, creating one at ${HOME}/.git-hooks"
    mkdir "${HOME}/.git-hooks"
    git config --global core.hooksPath ${HOME}/.git-hooks
  fi
  local hookpath=`git config --global --get core.hooksPath`

  # Make sure there is no existing commit-msg
  if [ -f $hookpath/commit-msg ]; then
    echo "The file $hookpath/commit-msg already exists. This script refuses to overwrite it"
    echo "Please delete the file and run this command again"
    exit 1
  fi

  # Copy the commit-msg to the hooks path
  local dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  cp $dir/commit-msg $hookpath

  echo "Adding the pair_with script to ${HOME}/.bashrc"
  echo "[ -f $dir/pair_with.sh ] && . $dir/pair_with.sh" >> ${HOME}/.bashrc
}

setup
