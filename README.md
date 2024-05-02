# Multi-digit Multiplexed Seven-Segment Display Driver with SPI Interface Using FPGA

This project is to design a multiplexed 4-digit seven-segment display with an SPI interface, capable of displaying digits based on commands received via SPI. The design utilizes the LMX03LF-6900C FPGA from Lattice and the AVR128DB48 microcontroller, programmed in VHDL.

## System Overview

The design uses a multiplexed approach to display digits on a seven-segment display using SPI communication. The system block diagram included in the repository provides a comprehensive view of the components and their interactions.

<p align="center">
  <img src="preview/diagram.jpeg">
</p>

### Components
Each component has its own source code with testbench in the "preview" folder.

- **Edge Detector (U1)**: Detects the positive edge of signals.
- **SPI RX Shifter (U2)**: Shifts in the serial data from SPI.
- **Buffer Register (U4)**: Holds the data received from the SPI interface.
- **Decoder 2-to-4 (U5)**: Decodes address bits to select one of the four-digit registers.
- **Hex Digit Registers (U6, U7, U8, U9)**: Store individual digit values.
- **Digit Mux (U10)**: Selects which digit to display based on the multiplexer control signals.
- **Seven Segment Driver (U11)**: Drives the seven-segment display.

## Hardware Setup

Detailed diagrams and pictures of the actual circuit setup are provided to aid in replicating the project setup.

<p align="center">
  <img src="preview/IMG_7140.jpeg" width="800px" height="600px">
</p>

## VHDL Modules

Each component is implemented as a separate VHDL module:

- `edge_det`
- `slv_spi_rx_shifter`
- `rx_buff_reg`
- `decoder_2to4`
- `hex_digit_reg`
- `load_digit_fsm`
- `hex_dig_mux`
- `hex_seven`

## Simulation

Testbenches for each module are available under the `testbenches` directory. Instructions on running the simulations using Aldec Active-HDL are provided.

## Synthesis and Programming

Instructions on synthesizing the design for the LMX03LF-6900C FPGA target PLD and programming it using Lattice Diamond are included.

## Acknowledgments

Special thanks to Prof. Short and the TA team for their guidance and support throughout the laboratory exercises.
