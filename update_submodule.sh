#!/bin/bash
set -x
SCRIPT_HOME=$(cd $(dirname $0)/; pwd)

BACKEND_PATH=$SCRIPT_HOME/backend
FRONTEND_PATH=$SCRIPT_HOME/frontend
SCRIPTS_PATH=$SCRIPT_HOME/scripts
SDK_PATH=$BACKEND_PATH/3rdparty/GlobalCacheSDK

function main() 
{
  cd $BACKEND_PATH
  git pull origin main

  cd $FRONTEND_PATH
  git pull origin master

  cd $SCRIPTS_PATH
  git pull origin main

  cd $SDK_PATH
  git pull origin main
}
main
