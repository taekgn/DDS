# Direct Digital Synthesiser (DDS) Circuit

## Timing Generation (**DIV8**, **DIV16**, **DIV4096**)
These 3 components can be found in Figure 2. The Nexys-3 board has a 100 MHz crystal clock. In this design the internal logic on the FPGA will use a 12.5 MHz clock. This is achieved by building a “divide by 8” counter (called **DIV8**) which produces the internal **CLK** signal from the Master clock input (**MCLK**) which is connected to Pin V10 of the FPGA on the development board.
Hint: draw the timings diagram on a sheet of paper before you start any coding.

Two further timing circuits are needed: **DIV16** which produces a pulse, one **CLK** long every 16 **CLK** clock cycles (called **CE** in the block diagram) and **DIV4096** which also produces a pulse, one **CLK** long every 4096 **CLK** cycles (called **MS** in the block diagram). Both pulse generators have a synchronous reset (**RES**).
Begin this laboratory by building a VHDL model and a test bench for each of these three circuits to verify that they work as expected. Hint: These circuits are very similar in structure and you should be able to re-use much of the code you develop.

## The Debounce Circuit (DEBOUNCE) Implemented by SYNC

Four slider switches (SW7 – SW4) will be used to program the output frequency of the phase accumulator (Pins T5, V8, U8, N8 respectively). To ensure proper operation of the circuit it is advisable to build a debounce circuit to ensure that there are no asynchronous glitches on these signals. Another debounce circuit is also required for Reset input which is connected to a push- button on the Nexys-3 board (Pin V2). The schematic shown in Fig 3 uses a Sync circuit rather than a proper debounce circuit (a simpler version).

## The Phase Accumulator (**PHASE_ACCU**) Circuit
The Phase Accumulator is built using an adder and a register with a synchronous reset RES as shown in Figure 4. On the rising edge of the clock, if CE = 1 the output of the adder will be stored in the 16-bit register. The adder is used to accumulate the previous value of the accumulator with the 4-bit input D. The output of the register will be used as the input into the waveform generator.

Build a VHDL model of this circuit and call it **PHASE_ACCU**. Devise a simple test-bench to test the output of the circuit when D = “0011”. What type of waveform do you expect to see?
Every **CLK** clock cycle, the input word is added to the previous value stored in the register (i.e accumulated). This will continue until the Accumulator overflows at which point the process begins again. When looking at the **MSB**s of the Accumulator output a sawtooth waveform is produced. The frequency of this waveform will be determined by the value input into the accumulator (referred to as the Phase Increment).
By using simple combinational logic it is possible to convert the output of the Phase Accumulator into any arbitrary waveform. The most common is a sine or cosine wave although triangle, square and any arbitrary shape is also possible.

## The Waveform Generator Circuit (WAVE_GEN)

Each laboratory group will be asked to generate a unique waveform generation circuit.
The circuit has a 5-bit input and will take 5 of the 16 output bits from the **PHASE_ACCU** circuit and use them to generate a 12-bit output that will be used as an input to the **DAC_INTERFACE** circuit. Which output bits should it take? The selection of which bits to use is done in the Port Mapping for this component in the DDS top level design.
The best method for generating an arbitrary waveform is by means of a lookup table (known as a LUT). In this experiment, you have 5 bits input, which will define how many entries there are in the table and 12 bits output which defines how big each entry is.
You need to create a look up table with maps the input entries to a corresponding output value for the waveform which is available in your Moodle submission folder.
Excel is a useful tool for generating such data tables. Bear in mind that waves are symmetrical about 0, but the output must always be a positive number.

## The DAC Interface Circuit (DAC_INTERFACE)

It is necessary to convert the digital output of the waveform generator into an analogue signal. To generate an analog signal it is necessary to use a Digital-to-Analog Converter (DAC). Neither the Xilinx chip nor the Nexys-3 board has a dedicated DAC so it is necessary to use an extra peripheral component. This is called a PMOD DA2 and is available from the Technical Support Centre. PMOD is a 6-pin or 12-pin interface standard used by Digilent (and increasingly by other companies) to connect additional functions/circuits to the main experimental board. The Nexys-3 board has 4 Pmod ports. Please connect your PMOD to Port JA1. The DA2 Pmod actually has two Digital-to-Analog converters on it. Although this experiment only needs one, past years’ groups have damaged some of the DAC devices so o/p 1 may not work, so you should program both outputs to generate the same data. The circuit that will be used to perform this conversion is the DAC121S101 which is manufactured by Texas Instruments. The data sheet for this peripheral component is available in the CAD1 Laboratory folder on Moodle. It is important that you look at this data sheet before implementing your design. Please read it.



## Bibliography
[1] NA, Divide by N clock [Online], February 12 2021. Available: <https://www.slideshare.net/DeepakFloria/divide-by-n-clock>  
[2] NA, VHDL BASIC Tutorial – Clock Divider [Online], February 12 2021. Available: <https://www.youtube.com/watch?v=8EO4gqlTHtc&list=WL&index=1&t=1s>  
[3] NA, 8 WAYS TO CREATE A SHIFT REGISTER IN VHDL [Online], March 28 2021. Available: <https://vhdlwhiz.com/shift-register/>  
[4] NA, “How To Generate Sine Samples in VHDL”, SURF VHDL [Online], March 1 2021. Available : <https://surf-vhdl.com/how-to-generate-sine-samples-in-vhdl/>  
[5] Daniel Kampert, “Playing audio with an FPGA“, Hackster [Online], March 26 2021. Available : <https://www.hackster.io/Kampino/playing-audio-with-an-fpga-d2bc85>  
