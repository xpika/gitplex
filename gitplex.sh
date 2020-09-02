#!/bin/bash
for A in $(find .  -mindepth 2 -type d | grep "\.git$" ); do dirname=$(dirname $A); echo mv $A $dirname/.gitplex; done
$1
for A in $(find . -mindepth 2 -type d  | grep "\.git$" ); do dirname=$(dirname $A); echo mv $dirname/.gitplex $A; done
