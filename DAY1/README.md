<h1 align="center">🌟 RISC-V SoC Tapeout – Week 0</h1> 
<br><br><br>
## 🚀 Getting Started with Digital VLSI SoC Design & Planning  

<p align="center">
<img src="https://github.com/user-attachments/assets/e2de537b-9671-4087-8e69-60fd8856c925" width="700" alt="Chip Modeling">
</p>

### 🟢 Step 1: Application & Chip Modeling  
- ✅ First, verify whether the **application itself is correct** or ❌ **wrong**.  
- 🖥️ Build the design in **C language** using the **GCC compiler** and given chip specifications.  
- 📏 **Golden Rule:**  

    ```text
    O0 == O1   → chip specification is valid 👍
    ```

---

## 🏗️ Step 2: RTL Development  

<p align="center">
<img src="https://github.com/user-attachments/assets/bbe5f959-7980-4ebc-b898-ebca21f9cad7" width="700" alt="RTL Development">
</p>

- ✍️ Hardware is described in **Register Transfer Level (RTL)** using languages like:  
  1️⃣ Verilog  
  2️⃣ VHDL  
  3️⃣ Bluespec  
  4️⃣ Cecile  

⚠️ **Critical Note:**  
- ⛔ Do **not** use non-synthesizable constructs in Verilog.  
- ✅ Keep the design **synthesizable & portable**.  

---

## ⚙️ Step 3: ASIC Flow – Processor & Peripherals  

<p align="center">
<img src="https://github.com/user-attachments/assets/45d56169-828a-42ae-a75c-eb15b32cc090" width="700" alt="ASIC Flow">
</p>

### 🔹 Processor (CPU Core)  

<p align="center">
<img src="https://github.com/user-attachments/assets/aec0a92c-c618-4777-9bfa-4b563ef4106b" width="600" alt="Processor Block">
</p>

-  After **synthesis**, the processor becomes a **Gate-Level Netlist (GLN)**.  
- 🧩 GLN = collection of **logic gates** mapped to **standard cell libraries**.  

---

### 🔹 Peripherals / IPs  

<p align="center">
<img src="https://github.com/user-attachments/assets/00a07b66-82d5-4ce0-a809-76a6486ca2e6" width="500" alt="Peripherals Block">
</p>

- 🛠️ **Peripherals** are reusable blocks connected to the processor.  
- They enhance functionality such as **I/O, communication, and timing**.  

| 🔧 Type | 📖 Description | 💡 Examples |
|---------|----------------|-------------|
| **Digital Macros (Synthesizable RTL)** | Written in Verilog/VHDL, synthesizable into gates | UART, SPI, I²C |
| **Analog IPs (Hard Macros)** | Pre-designed hard layouts, not synthesizable | PLL, ADC, DAC, SERDES |

---

## 🔗 Step 4: SoC Integration  

<p align="center">
<img src="https://github.com/user-attachments/assets/a39762ba-b4dc-4182-bc62-f021c47ef280" width="700" alt="SoC Integration">
</p>

- 🧩 Combine **processor + peripherals** into one **System-on-Chip (SoC)**.  
- ⚡ Ensure correct **interconnects, memory mapping, and power distribution**.  
- 🏆 End result = a **functional chip** ready for implementation.  

---

## 🛠️ Step 5: OpenLane Flow (RTL → GDSII)  

<p align="center">
<img src="https://github.com/user-attachments/assets/fc760372-935e-48ae-ad1d-7c9521fb3ac3" width="700" alt="OpenLane Flow">
</p>

<p align="center">
<img src="https://github.com/user-attachments/assets/6ec162bb-2fdf-450d-8a29-cd801159984d" width="700" alt="OpenLane Flow 2">
</p>

- 🏗️ **OpenLane** is the open-source ASIC flow used for **tapeout preparation**.  
- 🔄 Flow includes:  

    ```text
    RTL → Netlist → Floorplan → Placement → Routing → GDSII
    ```

- 🖼️ **GDSII** = Final chip mask layout used for fabrication.  

---

## ✅ Final Golden Rule  

For a valid & correct SoC →  


O1 == O2 == O3 == O4
---
<br><br><br>

<h1 align="center"> 🔳 Tools Installation Instructions 🌟 </h1> 
<br><br><br>


📌 **System Requirements**:  
- 🐧 Ubuntu 20.04+ (✅ I used Ubuntu 22.04)  
- 💾 6 GB RAM | 💽 50 GB HDD | ⚡ 4 vCPU  

---

## 🛠️ Installed Tools  
## Yosys Installation:
  <img width="843" height="580" alt="Screenshot from 2025-09-20 01-16-44" src="https://github.com/user-attachments/assets/6ad91cba-87be-464b-aa25-fc865a04b514" />

✅ Verify with:
```bash
yosys --version
```
   <img width="843" height="357" alt="Screenshot from 2025-09-20 01-17-14" src="https://github.com/user-attachments/assets/a9f80706-15a7-4f6f-b4ea-b0bbaa8c978c" />

   
### 🔹 Icarus Verilog (iverilog)
```bash
sudo apt-get update
sudo apt-get install iverilog
```
## Installation image:
  
<img width="843" height="357" alt="Screenshot from 2025-09-20 01-17-34" src="https://github.com/user-attachments/assets/fe8ba90b-e2ab-44bc-b180-e4fb9a3a9aee" />

✅ Verify with:
```bash
iverilog -V
```
  <img width="843" height="562" alt="Screenshot from 2025-09-20 01-18-49" src="https://github.com/user-attachments/assets/96ce9c74-d497-4607-8ca0-493140b30f60" />

### 🔹 GTKWave
```bash
sudo apt-get update
sudo apt-get install gtkwave
```
## Installation :

<img width="1000" height="852" alt="Screenshot from 2025-09-20 01-19-45" src="https://github.com/user-attachments/assets/22ab9dbc-4177-4925-a233-75c73aff2fc7" />

✅ Verify with:
```bash
gtkwave --version
```
  <img width="1000" height="336" alt="Screenshot from 2025-09-20 01-20-05" src="https://github.com/user-attachments/assets/488eb464-9d37-4a16-a4aa-622936764923" />

## 🔄 Simple RTL Design Flow (Using Installed Tools)

To validate the toolchain, a small Verilog design can be tested end-to-end.
### Make a separate directory 
```verilog
mkdir projects
```
<img width="1000" height="336" alt="Screenshot from 2025-09-20 01-20-05" src="https://github.com/user-attachments/assets/ba4427ac-5d74-495a-ad86-b0d9fdca5207" />

<img width="902" height="336" alt="Screenshot from 2025-09-20 01-21-13" src="https://github.com/user-attachments/assets/05f13185-0a7c-4f69-b055-27bbe74533af" />

- using nano editor create and open a .v file for full_adder design code

### Step 1: Write a Verilog file  
Example: `full_adder.v`
```verilog
module full_adder(
    input a, b, cin,
    output sum, cout
);
    assign sum  = a ^ b ^ cin;                // Sum = XOR of all inputs
    assign cout = (a & b) | (b & cin) | (a & cin); // Carry = majority function
endmodule
```

<img width="902" height="336" alt="Screenshot from 2025-09-20 01-22-07" src="https://github.com/user-attachments/assets/00b1f7fb-f3b2-4ae3-a807-64b9da3bb7c9" />


### Step 2: Write a Testbench
Example: `tb_fyll_adder.v`
```verilog
`timescale 1ns/1ps
module tb_full_adder;
    reg a, b, cin;
    wire sum, cout;

    // Instantiate the full adder
    full_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Dump waves
        $dumpfile("full_adder.vcd");
        $dumpvars(0, tb_full_adder);

        // Truth table
        $display(" A B Cin | Sum Cout ");
        $display("-------------------");

        a=0; b=0; cin=0; #10;
        $display(" %b %b  %b  |  %b    %b", a,b,cin,sum,cout);

        a=0; b=0; cin=1; #10;
        $display(" %b %b  %b  |  %b    %b", a,b,cin,sum,cout);

        a=0; b=1; cin=0; #10;
        $display(" %b %b  %b  |  %b    %b", a,b,cin,sum,cout);

        a=0; b=1; cin=1; #10;
        $display(" %b %b  %b  |  %b    %b", a,b,cin,sum,cout);

        a=1; b=0; cin=0; #10;
        $display(" %b %b  %b  |  %b    %b", a,b,cin,sum,cout);

        a=1; b=0; cin=1; #10;
        $display(" %b %b  %b  |  %b    %b", a,b,cin,sum,cout);

        a=1; b=1; cin=0; #10;
        $display(" %b %b  %b  |  %b    %b", a,b,cin,sum,cout);

        a=1; b=1; cin=1; #10;
        $display(" %b %b  %b  |  %b    %b", a,b,cin,sum,cout);

        $finish;
    end
endmodule

```

<img width="902" height="673" alt="Screenshot from 2025-09-20 01-23-08" src="https://github.com/user-attachments/assets/eb5506d3-1346-42d5-8194-648be787f142" />

---
- So we could able to see the files has been created

<img width="1078" height="433" alt="Screenshot from 2025-09-20 01-23-45" src="https://github.com/user-attachments/assets/b6e6e1a1-bf96-4b16-a574-389a68839e42" />

### Step 3: Simulate with Icarus Verilog
```bash
iverilog -o and_gate_tb tb_and_gate.v and_gate.v
vvp and_gate_tb
```
## Executed Image
  <img width="1078" height="484" alt="Screenshot from 2025-09-20 01-26-12" src="https://github.com/user-attachments/assets/3ea21ef1-37a8-43d7-a0b9-6270fa2f13ae" />

✅ Successful simulation with Icarus Verilog – generated and_gate.vcd for waveform view in GTKWave.

<img width="1078" height="607" alt="Screenshot from 2025-09-20 01-26-47" src="https://github.com/user-attachments/assets/56b4c833-a181-4576-ba5f-5134144f74a3" />

### Step 4: View Waveforms in GTKWave
```bash
gtkwave and_gate.vcd
```
## Executed Image
  <img width="1078" height="797" alt="Screenshot from 2025-09-20 01-28-05" src="https://github.com/user-attachments/assets/782fef0e-4d09-42d7-a437-8cdc9d8a14ec" />

### Step 5: Optional – Synthesis with Yosys
```bash
yosys
yosys> read_verilog and_gate.v
yosys> synth -top and_gate
yosys> write_json and_gate.json
```
✅ Yosys started and Verilog design (and_gate.v) was read into synthesis flow. 

 <img width="827" height="448" alt="Screenshot from 2025-09-20 01-31-00" src="https://github.com/user-attachments/assets/5549a558-4a26-4c62-b994-2d702aed64fe" />

✅ Yosys synthesis completed – statistics show 1 logic cell ($_AND_) inferred.

<img width="827" height="688" alt="Screenshot from 2025-09-20 01-31-21" src="https://github.com/user-attachments/assets/c6cee599-8800-4912-9505-83baf35799a8" />

✅ and_gate.json generated – JSON netlist representation of the synthesized AND gate.

<img width="734" height="1109" alt="Screenshot from 2025-09-20 01-33-37" src="https://github.com/user-attachments/assets/fd98cf9c-66d3-4e52-97a8-ae21b047a8bd" />

## To Visualize The design use these command
```bash
yosys
read_verilog and_gate.v
synth -top and_gate #top_module_name
show
```
## Design code visualization 

 <img width="1910" height="1089" alt="Screenshot from 2025-09-20 01-32-23" src="https://github.com/user-attachments/assets/573e3b36-39f8-45bd-bbe6-4f4b9e3b0dac" />

  
✅ Toolchain Validation

🖥️ Icarus Verilog (iverilog) → Compiles & simulates Verilog code

📈 GTKWave (gtkwave) → Visualizes simulation waveforms (VCD files)

🛠️ Yosys → Performs RTL synthesis to gate-level netlist
