#!/usr/bin/env bash

# small todo app
# based on https://github.com/jeffWelling/ticgit
#
# run $0 web to start ticgitweb and point your local browser at it
# 
# dependencies:
# gem install git sinatra haml sass TicGit-ng

_basedir=~/.todo
_gitdir=${_basedir}/.git

mkdir -p $_basedir
pushd $_basedir >/dev/null

if [ ! -d $_gitdir ] ; then
  # initialize git repo
  GIT_DIR=$_gitdir git init
  # create ticgit branch
  GIT_DIR=$_gitdir git commit --allow-empty -m 'init'
  GIT_DIR=$_gitdir git checkout master
  ti init
fi

# wrapper commands
if [ "$1" = "web" ] ; then
  # start ticgitweb
  (sleep 2 && xdg-open http://localhost:4567) &
  ticgitweb
else
  # command abbreviations
  case "$1" in
    "")
      cmd=list
      ;;
    "as")
      cmd=assign
      ;;
    "at")
      cmd=attach
      ;;
    "co")
      cmd=checkout
      ;;
    "c")
      cmd=comment
      ;;
    "cl")
      cmd="state resolved"
      ;;
    "close")
      cmd="state resolved"
      ;;
    "h")
      cmd=help
      ;;
    "l")
      cmd=list
      ;;
    "n")
      cmd=new
      ;;
    "p")
      cmd=points
      ;;
    "r")
      cmd=recent
      ;;
    "s")
      cmd=show
      ;;
    "st")
      cmd=state
      ;;
    "sy")
      cmd=sync
      ;;
    "t")
      cmd=tag
      ;;
    *)
      cmd="$1"
      ;;
  esac
  shift
  ti $cmd "$@"
fi

popd>/dev/null
