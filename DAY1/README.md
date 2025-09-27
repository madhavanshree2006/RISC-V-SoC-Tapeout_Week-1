
<h1 align="center">🌟 RISC-V SoC Tapeout – Week 1️⃣</h1>
<br><br>

<h2 align="center">🚀 Day 1 - Introduction to Verilog RTL Design and Synthesis</h2>
<br>

## 👉 Introduction to Open-Source Simulator: Icarus Verilog (iverilog)

### SKY130RTL D1SK1 L1: Introduction to Icarus Verilog Testbench

### 💻 **Simulator?**

- A simulator is a tool 🛠️ used to check your design or intent, to verify that the RTL design meets the specification (SPEC).

### 🛠️ **How does Simulator works?**

- It works according to the change on the I/P signal, the o/p is evaluated.
- ❗ No change to the I/P ≡ No change to the O/P

🔵 **Testbench (TB)**

- A testbench is used to check whether the RTL is obeying the specification or not ✅❌.

---

<p align="center">
<img src="./ASSETS/1.png" width="700" alt="image 1"/>
</p>

1. **Stimulus Generator** -> Provides primary inputs
2. **Design** -> RTL design that is know as Unit under test(UUT)
3. **Stimulus Observer** -> Accepts the primary outputs from the UUT
    
    ⚠️ **Note**:
    
    - The Design may have 1 or more Primary inputs, 1 or more primary outputs.
    - TB doesn't have a primary inputs or primary outputs.

<p align="center">
<img src="./ASSETS/2.png" width="700" alt="image 2"/>
</p>

📌 ( Design + TB ) -> IVERILOG -> .vcd file( Value Change Dump file ) -> GTKWave( Wave form viwer ) -> Wavefoms (٨ـﮩﮩ٨ـ)

---

## 👉 Labs using iverilog and gtkwave 🖥️🔬

### SKY130RTL D1SK2 L1 Lab1 introduction to lab

🔴 TOOL FLOW SETUP  </>

```bash
mkdir VLSI

```

<p align="center">
<img src="./ASSETS/3.png" width="700" alt="image 3"/>
</p>

🔴 Move into VLSI folder 📂 ->  clone the git [https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git](https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git) </>

<p align="center">
<img src="./ASSETS/4.png" width="700" alt="image 4"/>
</p>

```bash
cd VLSI
git clone <https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git>

```

<p align="center">
<img src="./ASSETS/5.png" width="700" alt="image 5"/>
</p>

🔴 Then move to sky130RTLDesignAndSynthesisWorkshop 📂  </>

```bash
cd sky130RTLDesignAndSynthesisWorkshop
ls

```

<p align="center">
<img src="./ASSETS/6.png" width="700" alt="image 6"/>
</p>

🔴 Move to my_lib 📂 -> move to verilog_model 📂 -> ls   </>

```bash
cd my_lib
cd verilog_model
ls

```

<p align="center">
<img src="./ASSETS/7.png" width="700" alt="image 7"/>
</p>

🔴 Move to folder 📂 verilog_files -> then list the folder 📂</>
- you will see  👀 this folder contains the all standard cell verilog model we need

```bash
cd ../
cd verilog_files
ls

```

<p align="center">
<img src="./ASSETS/8.png" width="700" alt="image 8"/>
</p>

---

### SKY130RTL D1SK2 L2 Lab2 Introduction iverilog gtkwave part1

🔵 **MUX (Multiplexer)**

- 🟡 A multiplexer is a **combinational digital circuit** that takes multiple data inputs and provides only single output.
- 🟡 Multiplexer has **2ⁿ input lines and 1 output line, where *n* is the number of select lines**.

<p align="center">
<img src="./ASSETS/9.png" width="700" alt="image 9"/>
</p>

<p align="center">
<img src="./ASSETS/10.png" width="700" alt="image 10"/>
</p>

🔴 Navigate to verilog_files 📂 and load the **good_mux.v (design file)** and t**b_good_mux.v** </>

```bash
cd verilog_files
iverilog good_mux.v tb_good_mux.v

```

<p align="center">
<img src="./ASSETS/11.png" width="700" alt="image 11"/>
</p>

🔴 It will create a file named as **a.out** -> then exectue the **a.out file**-> it will produce the .vcd file

<p align="center">
<img src="./ASSETS/14.png" width="700" alt="image 12"/>
</p>

```bash
./a.out

```

<p align="center">
<img src="./ASSETS/12.png" width="700" alt="image 13"/>
</p>

🔴 Use the **GTWave viewer** to see the results of the iverilogs .vcd file in to see 👀 Waveforms ٨ـﮩﮩ٨ـ

```bash
gtkwave tb_good_mux.vcd

```

<p align="center">
<img src="./ASSETS/13.png" width="700" alt="image 14"/>
</p>

---

### SKY130RTL D1SK2 L3 Lab2 Introduction iverilog gtkwave part2

🔴 To look inside the code of **good_mux.v** and **tb_good_mux.v** -> use any text editor to open the file

```bash
gvim tb_good_mux.v -o good_mux.v

```

<p align="center">
<img src="./ASSETS/15.png" width="700" alt="image 15"/>
</p>

<p align="center">
<img src="./ASSETS/16.png" width="700" alt="image 16"/>
</p>

🔵 We can see in **Testbench** there is no primary input 📥 or output 📤

---

🔵 In the TB file, the design code is instantiated as **UUT → Unit Under Test**

🔵 Using the **stimulus block**, we can generate custom inputs with custom time ranges (e.g., `#300ns`)

<p align="center">
<img src="./ASSETS/17.png" width="700" alt="image 17"/>
</p>

---

## 👉 Introduction to Yosys and Logic synthesis

### SKY130RTL D1SK3 L1 Introduction to yosys

<p align="center">
<img src="./ASSETS/35.png" width="700" alt="image 18"/>
</p>

🔵 **YOSYS** -> is a open source synthesizer tool used widely

🟠 ***YOSYS setup***

<p align="center">
<img src="./ASSETS/18.png" width="700" alt="image 19"/>
</p>

⚠️ **The netlist is the representation of the design in the form of standard cells**

🟠 ***Verify the Synthesize***

<p align="center">
<img src="./ASSETS/19.png" width="700" alt="image 20"/>
</p>

⚠️ **The set of primary inputs (I/P) and primary outputs (O/P) remains the same between the RTL design and the synthesized netlist → the same testbench can be used❗**

---

### SKY130RTL D1SK3 L2 introduction to logic synthesis part1

### 1️⃣ **RTL Design**

📌 **What is RTL Design?**

- 🟡 RTL (Register Transfer Level) is a behavioral representation of a digital circuit that shows how data flows between registers.
- 🟡 Written using HDLs like Verilog.
- 🟡 Describes circuit behavior on clock cycles (posedge clk) and resets.

<p align="center">
<img src="./ASSETS/20.png" width="700" alt="image 21"/>
</p>

📝 Example – RTL Code Skeleton

```bash
module sample_code (
    input clk, rst,
    output result, done
);
    always @ (posedge clk, posedge rst)
        if (rst)
            ; // reset condition
        else
            ; // functional behavior
endmodule

```

👉 This is the behavioral representation of the required specification.

---

### 2️⃣ **Synthesis**

📌 **What is Synthesis?**

- 🟡 Process of converting RTL code (behavioral) → Digital Logic Circuit (gate-level).
- 🟡 Tool used: Yosys (open-source).
- 🟡 After synthesis, you get a netlist made of standard cells from .lib.

📝 Example RTL Code

```bash
module good_mux (input i0 , input i1 , input sel , output reg y);
always @ (*)
begin
	if(sel)
		y <= i1;
	else
		y <= i0;
end
endmodule

```

🔄 **RTL to Digital Logic Mapping**

```bash
RTL Code   --->   Synthesis   --->   Gate-Level Netlist

```

- Inputs: `clk`, `rst`
- Registers + Logic
- Outputs: `result`, `done`

---

<p align="center">
<img src="./ASSETS/21.png" width="700" alt="image 22"/>
</p>

### 3️⃣ **The .lib File**

📌 **What is .lib?**

<p align="center">
<img src="./ASSETS/22.png" width="700" alt="image 23"/>
</p>

- 🟡 Standard Cell Library used during synthesis.
- 🟡 Contains logical modules (basic building blocks like AND, OR, NOT, DFF, etc.).
- 🟡 Provides different versions (flavors) of the same gate:
    - Slow 🐢
    - Medium 🚶
    - Fast 🚀

📝 **Example RTL Code (Addition)**
module add(
input [3:0] num1,
input [3:0] num2,
output [4:0] result
);
assign result = num1 + num2;
endmodule

🔴 After synthesis, this will map to available gates inside `.lib`, e.g.:

```bash
and2_low  (.a(num1[1]), .b(num2[1]), .y(...));
and2_med  (...);
and3_fast (...);

```

👉 Output: Netlist that uses cells from .`lib`.

---

### **4️⃣ Why Different Flavors of Gates?**

**📌 Key Concept – Timing Equation**

```bash
TCLK > TCQ_A + TCOMBI + TSETUP_B

```

- `TCQ_A` → Clock to Q delay of flip-flop A
- `TCOMBI` → Combinational logic delay
- `TSETUP_B` → Setup time of flip-flop B

<p align="center">
<img src="./ASSETS/23.png" width="700" alt="image 24"/>
</p>

⚡ **Why multiple versions (slow 🐢 / medium 🚶/ fast🚀)?**

- 🟡 Faster cells → reduce TCOMBI, improve performance.
- 🟡 But **faster ≠ always better:**
    - Faster cells → consume more power, larger area.
    - Slower cells → power-efficient but increase delay.

👉 Synthesis tool automatically chooses the right flavor based on **timing + power trade-offs.**

✅ Learnings

RTL Design: Behavioral description using Verilog.

Synthesis: Converts RTL → Gate-level netlist using .lib.

.lib File: Library of standard cells with multiple flavors.

Different flavors of gates: Used to balance speed, power, and area.

---

### **SKY130RTL D1SK3 L2 introduction to logic synthesis part1**

### **1️⃣ Why We Need Slow Cells?**

📌 Key Concept – **Hold Time Equation**

To ensure **correct data capture** in sequential circuits:

```bash
Thold_B < TCQ_A + TCOMBI

```

- **TCQ_A** → Clock to Q delay of flip-flop A
- **TCOMBI** → Combinational logic delay between flip-flops
- **Thold_B** → Hold time requirement of flip-flop B

⚠️ Problem: If all cells are too fast → data may reach flip-flop B too quickly → **hold violation**

🛠️ Solution: Use **slower cells** in critical paths to intentionally delay signals.

---

### **2️⃣ Faster Cells vs Slower Cells**

| Feature | Faster Cells | Slower Cells |
| --- | --- | --- |
| **Purpose** | Reduce combinational delay → meet setup time | Increase delay → meet hold time |
| **Transistor sizing** | Wider transistors → more current | Narrower transistors → less current |
| **Delay** | Low delay | High delay |
| **Area & Power** | Larger area, higher power | Smaller area, lower power |
| **Trade-off** | Performance gain at cost of area/power | Power & area efficient, may limit speed |

⚡ Key Insight: Faster cells improve speed but **consume more power and area**, slower cells fix hold issues but may reduce max frequency.

---

### **3️⃣ Selection of Cells**

📌 Guiding the Synthesizer:

- The **synthesizer chooses cell flavors** based on **timing constraints** provided in your design.
- **Constraints determine trade-offs**:

| Scenario | Effect |
| --- | --- |
| More use of fast cells | Circuit meets performance, but power & area may be high |
| More use of slow cells | Circuit is power-efficient, but may be sluggish → may not meet performance |
| Balanced selection (with constraints) | Optimized circuit in terms of speed, power, and area |

📌 Proper **constraints** guide the synthesizer to select the optimal mix of fast and slow cells.

### **4️⃣ Synthesis Illustration**

**RTL Code Example:**

<p align="center">
<img src="./ASSETS/24.png" width="700" alt="image 24"/>
</p>

```bash
module mux_ff (
    input A, B, sel, clock, reset,
    output reg Q
);
    wire int;
    assign int = sel ? A : B;

    always @(posedge clock or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= int;
    end
endmodule

```

🔄 **Process:**

<p align="center">
<img src="./ASSETS/25.png" width="700" alt="image 25"/>
</p>

- 🟡 RTL → Synthesis Tool (Yosys) → **Netlist**
- 🟡 Netlist uses **gates from .lib** (AND, OR, NOT, DFF, etc.)
- 🟡 Result: Gate-level implementation ready for further stages (place & route, timing analysis)

✅ **Learnings**

- Slow cells are critical to prevent **hold violations**.
- Fast cells reduce combinational delay but increase **power & area**.
- Cell selection must be guided with **timing constraints**.
- Synthesis converts **RTL code → Netlist** using `.lib` cells.

---

### **SKY130RTL D1SK4 L1 Lab3 Yosys 1 good mux Part1**

**📌 Key Concept - To synthesize the 2x1_mux to obtain netlist**

🔴 Move to verilog_files 📂  </>

```bash
yosys
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog good_mux.v

```

- 🟡 Opening yosys
- 🟡 Reading the sky130_fd_sc_hd__tt_025C_1v80.lib library file
- 🟡 Then reads the good_mux.v RTL file

<p align="center">
<img src="./ASSETS/26.png" width="700" alt="image 26"/>
</p>

---

🔴 Sythesize the RTL </>

```bash
synth -top good_mux

```

<p align="center">
<img src="./ASSETS/27.png" width="700" alt="image 27"/>
</p>

- 🟡 The synthesize starts to happen by set the **good_mux.v** file as the **Top file**.

<p align="center">
<img src="./ASSETS/28.png" width="700" alt="image 28"/>
</p>

🔴 Create the Netlist of the RTL</>

```bash
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

```

<p align="center">
<img src="./ASSETS/29.png" width="700" alt="image 29"/>
</p>

- 🟡 The result be like below

<p align="center">
<img src="./ASSETS/30.png" width="700" alt="image 30"/>
</p>

---

🔴 visualize the Synthesized netlist RTL</>

```bash
show

```

<p align="center">
<img src="./ASSETS/31.png" width="700" alt="image 31"/>
</p>

---

### **SKY130RTL D1SK4 L2 Lab3 Yosys 1 good mux Part2**

**📌 Elobrating the generated netlist**

<p align="center">
<img src="./ASSETS/32.png" width="700" alt="image 32"/>
</p>

- This is the visualization of the synthesized RTL

---

### **SKY130RTL D1SK4 L3 Lab3 Yosys 1 good mux Part3**

**📌 Key Concept - Key Concept - understanding the netlist generating processes**

- To write the generated netlist of the RTL use the following command

```bash
write_verilog good_mux_netlist.v
nano good_mux_netlist.v

```

<p align="center">
<img src="./ASSETS/33.png" width="700" alt="image 33"/>
</p>

<p align="center">
<img src="./ASSETS/34.png" width="700" alt="image 34"/>
</p>

---
