#!/bin/bash

rm -f fif

clear
iverilog -Wall -s FIFO -o fif RTL/FIFO.sv

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi


