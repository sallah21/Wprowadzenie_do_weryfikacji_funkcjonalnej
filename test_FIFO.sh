#!/bin/bash

rm -f FIFO_TB

clear
iverilog -Wall -s FIFO_tb -o FIFO_TB RTL/FIFO.sv VERIF/FIFO_tb.sv

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi

vvp FIFO_TB

if [ $? -eq 1 ]; then
    echo Simulation failure
    exit 1
fi



gtkwave FIFO_TB.gtkw
if [ $? -eq 1 ]; then
    echo gtk wave error 
    exit 1
fi

echo "All tests completed successfully"



