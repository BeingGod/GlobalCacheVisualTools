#!/bin/bash
set -x
SCRIPT_HOME=$(cd $(dirname $0)/; pwd)
NODES=ceph[2-3],client1

function main()
{
    echo "[WARN] sync scripts start"
    
    pdsh -w $NODES mkdir -p $SCRIPT_HOME
    pdcp -w $NODES -r $SCRIPT_HOME/scripts $SCRIPT_HOME

    echo "[WARN] sync scripts end"
}
main
