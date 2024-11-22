#!/bin/bash

rm -f fsm

clear
iverilog -Wall -s FSN -o fsm RTL/FSM.sv

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi


