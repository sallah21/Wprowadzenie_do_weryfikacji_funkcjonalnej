#!/bin/bash

rm -f fif
rm -f *.cf
rm -f *.json
rm -f *.vhdl

clear

# Compile SystemVerilog
echo "Compiling SystemVerilog..."
iverilog -Wall -s FIFO -o fif RTL/FIFO.sv

if [ $? -eq 1 ]; then
    echo "SystemVerilog compilation failure"
    exit 1
fi

# Convert to VHDL using Yosys and GHDL
echo "Converting to VHDL..."
yosys -s convert.ys
if [ $? -eq 1 ]; then
    echo "Yosys conversion failure"
    exit 1
fi

ghdl synth --std=08 --out=vhdl -e FIFO FIFO_netlist.json > FIFO_converted.vhdl
if [ $? -eq 1 ]; then
    echo "GHDL synthesis failure"
    exit 1
fi

# Analyze and elaborate VHDL files
echo "Analyzing VHDL files..."
ghdl -a --std=08 FIFO_converted.vhdl
ghdl -a --std=08 VERIF/tb_tab.vhdl

if [ $? -eq 1 ]; then
    echo "VHDL analysis failure"
    exit 1
fi

echo "Elaborating..."
ghdl -e --std=08 fifo_tb

if [ $? -eq 1 ]; then
    echo "VHDL elaboration failure"
    exit 1
fi

# Run simulation
echo "Running simulation..."
ghdl -r --std=08 fifo_tb --wave=wave.ghw

echo "Simulation complete. Use gtkwave wave.ghw to view waveforms"
