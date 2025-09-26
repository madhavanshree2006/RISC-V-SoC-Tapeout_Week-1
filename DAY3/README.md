<h1 align="center">🌟 RISC-V SoC Tapeout – Week 1️⃣</h1>
<br><br>

<h2 align="center">🚀 Day 3 -  Combinational and sequential optmizations</h2>
<br>



# **👉** SKY130RTL D3SK1 L1 – Introduction to Optimizations (Part 1)

This module introduces **logic optimizations** in digital design — techniques to make designs more efficient in **area, power, and performance** .

In digital logic we have two major types:

- **Combinational Logic** 🔹
- **Sequential Logic** 🔹

Here we focus on **combinational logic optimization**.

---

## **📌** Why Combinational Logic Optimization?

The goal is to **squeeze logic** to get the most optimized design. Benefits:

- **Reduced area** on silicon
- **Lower power** consumption
- **Improved overall efficiency**

### **🧩**Techniques used

1. **Constant Propagation** – propagate known constants through logic (direct/simple).
2. **Boolean Logic Optimization** – simplify complex boolean expressions using **K-map**, **Quine–McCluskey**, algebraic reductions, etc.

---

## 1️⃣ Constant Propagation — Example (AOI → INV)

Consider an AND-OR-INVERT (AOI) function:

![image1]

```
Y = (A · B + C)̅

```

**Scenario:** Tie `A = 0` (ground).

- `B · 0 = 0` → `C + 0 = C` → invert → `Y = C̅`
- **Optimized result:** AOI reduces to a **single inverter** 🔄

**🧩 Impact on CMOS:**

- AOI implementation → **6 MOSFETs**
- Inverter → **2 MOSFETs**

**![image 2]**

✅ **Result:** less area, less power (transistor count ↓).

---

## 2️⃣ Boolean Logic Optimization — Example (ternary/MUX-like)

Original (MUX-like):

![image3]

```
Y = A ? (B ? A : 0) : C̅
```

╰┈➤ Step-by-step:

- If `A = 0` → `Y = C̅`
- If `A = 1` → inner becomes `B ? A : 0` → since A=1 → becomes `AC`
    
    Combine:
    

```
Y = A̅·C̅ + A·B·C + B̅·A·C
```

Simplify (take common terms):

```
=> AC + A̅·C̅
=> Y = A ⊕ C    (XOR) ✖️
```

✅ **Result:** complex-looking expression → minimal form (XOR). Less logic, better efficiency

---

# **👉**SKY130RTL D3SK1 L2 – Introduction to Optimizations (Part 2)

This lecture focuses on **sequential logic optimizations**, mainly **sequential constant propagation**, and gives an overview of advanced techniques (state optimization, retiming, cloning).

---

## 1️⃣ Sequential Logic Optimization — Categories

- **Basic** 🔹
    - Sequential constant propagation (covered in labs)
- **Advanced** 🔹
    - State optimization
    - Retiming
    - Sequential logic cloning

---

## 2️⃣ Sequential Constant Propagation

Works like combinational constant propagation but applied to sequential elements (flip-flops).

### 💡Example 1 — Simple D-FF

**Setup:**

- `D = 0` (tied low)
- `reset` connected

![image4]

**Observation:**

- If `reset` applied → `Q = 0`
- If `reset` not applied → `Q = 0` (because `D = 0`)
    
    → `Q` is **always 0**
    

**Downstream:** if `Y = A · Q̅ + ...` and `Q = 0` → `Q̅ = 1` → `Y` simplifies to constants (e.g., 1).

✅ **Impact:** gates feeding `Y` can be removed → optimization.

---

### ❗ Important Caveat — Asynchronous Inputs (set/reset)

Consider a **set-FF** with `D = 0`.

![image5]

- `set = 1` → `Q = 1` **immediately** (asynchronous)
- `set = 0` → `Q` returns to `0` only at **next clock edge** (synchronous)

**Key insight:** `Q` takes both `0` and `1` depending on `set` & clock → **not a constant**.

- **Therefore:** sequential constant propagation **cannot** be applied → **retain the flop**.

⚠️ **Rule:** A flip-flop with `D` tied to a constant is **not automatically** a sequential constant. For propagation, `Q` must be constant **under all control/clock/asynchronous conditions**.

---

## 3️⃣ Advanced Sequential Techniques (overview)

- **State Optimization** — remove/merge unused states to condense FSM.
- **Retiming** — move flops across combinational logic to balance path delays (we’ll see more in L3).
- **Sequential Logic Cloning** — duplicate sequential logic for physical/timing reasons.

These are **conceptual tips** for complex designs; labs focus on basic sequential constant propagation.

---

# **👉**SKY130RTL D3SK1 L3 – Introduction to Optimizations (Part 3)

This lecture covers **advanced sequential optimizations**: **state optimization**, **logic cloning**, and **retiming** — theory-only in this course, but essential for real-world design.

---

## 1️⃣ State Optimization

- **Concept:** Eliminate/merge unused or redundant states to create a **condensed state machine**.
- **Impact:** Fewer states → simpler sequential logic → lower area/power/complexity.

---

## 2️⃣ Logic Cloning (Physical-Aware Synthesis)

**🚩 Problem:** A logic node `A` drives multiple FFs placed far apart in the floorplan → **large routing delays**.

**Example floorplan:**

- Flop A at corner1, Flop B at corner2, Flop C at corner3. Long interconnect delays A→B and A→C.

**✅Solution — Clone logic A:**

- Duplicate logic (`A1`, `A2`) and place copies near B and C.
- If `A` had **large positive slack**, cloning is safe (timing still met).

**Result:**

- Local drivers reduce routing delay → timing closure easier.
- Functionality preserved (two copies drive same logical value). 🏗️

✅ **Key idea:** cloning trades a small area increase for improved timing.

---

## 3️⃣ Retiming

**⏱️ Concept:** Move flip-flops across combinational logic to **balance combinational delays** and increase max clock frequency.

**Example:**

- Section1 delay = **5 ns**
- Section2 delay = **2 ns**
- Max clock limited by longer path → **200 MHz** (5 ns)

**Retiming action:** move some logic from Section1 → Section2

- New delays: Section1 = **4 ns**, Section2 = **3 ns**
- New max freq = min(4 ns, 3 ns) → **250 MHz** ✅

**Insight:** Use available **slack** to redistribute delay and raise performance ⏱️.

---

# 👉SKY130RTL D3SK2 L1 – Lab06 Combinational Logic Optimisations (Part 1)

Welcome to this module on **Combinational Logic Optimization**.

In this lab, we explore **Boolean simplifications** using Verilog files and observe how synthesis tools optimize them automatically ⚡.

---

## 📌 Setup

We are working inside the **`verilog_files/`** directory.

Files used in this lab:

- `opt_check.v`
- `opt_check2.v`
- `opt_check3.v`, `opt_check4.v` (later)

Each file demonstrates a different scenario of logic optimization.

---

## 1️⃣ File: `opt_check.v`

```verilog
module opt_check (input a , input b , output y);
	assign y = a?b:0;
endmodule
```

**Code behavior:**

- If `a = 1` → `y = b`
- If `a = 0` → `y = 0`

This is equivalent to a **2×1 MUX**.

**🤏Simplification:**

Y = a·b

✅ Result → a **2-input AND gate**.

---

## 2️⃣ File: `opt_check2.v`

```verilog
module opt_check2 (input a , input b , output y);
	assign y = a?1:b;
endmodule
```

**Code behavior:**

- If `a = 1` → `y = 1`
- If `a = 0` → `y = b`

So:
Y = a + (a̅·b)

makefile
Copy code

**🤏Simplification:**

This reduces to:

Y = a + b

✅ Result → an **OR gate**.

📌 Note: This transformation has a **special Boolean identity** name — try to recall/refer to it. (Hint: It is a standard Boolean simplification law.)

---

## 🔧 Yosys Flow Commands

### File: `opt_check.v`

For each file, we use the following synthesis flow:

```
yosys> read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> read_verilog opt_check.v
yosys> synth -top opt_check
yosys> opt_clean -purge
yosys> abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> show
```

- `opt_clean -purge` → removes unused cells & performs constant propagation.
image9
- `abc -liberty` → technology mapping with standard cell library.

### File: `opt_check2.v`

```
yosys> read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> read_verilog opt_check2.v
yosys> synth -top opt_check2
yosys> opt_clean -purge
yosys> abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> show
```

---

## 🏗️ Lab Observations

- For **`opt_check.v`** → Yosys produces a **2-input AND gate** ✅

image 10

- For **`opt_check2.v`** → Yosys produces logic equivalent to an **OR gate**, but often implemented via **NAND/NOR** style depending on library constraints.

image 11

📌 Example: Since OR gates require stacked PMOS transistors (less efficient), tools may realize it using **NAND + INV** style for better performance.

---

# 👉**SKY130RTL D3SK2 L2 Lab06 Combinational Logic Optimisations (part2)**

**1. NAND simplification using De-Morgan’s Theorem**

- The given circuit is: **inverter + inverter + AND gate**.
- By De-Morgan’s theorem:
    
    (A·B)’ = A’ + B’
    
- Two inverters back-to-back cancel each other out.
- ✅ Final simplification → **OR gate** (which matches the expectation from `opt_check2`).

---

## 3️⃣ File: `opt_check3.v`

```verilog

module opt_check3 (input a , input b, input c , output y);
	assign y = a?(c?b:0):0;
endmodule
```

![image12]

- In `opt_check3`, `y` depends on `a` and `c`:
    - If `a = 0 → y = 0`
    - If `a = 1` and `c = 1 → y = b`
    - Else → `y = 0`
- Boolean simplification:
    
    y = (A·(B·C)) = **A·B·C**
    
- ✅ Final circuit → **3-input AND gate**

---

**3. Running the flow in Yosys**

Steps to execute:

1. Invoke Yosys

```verilog
yosys> read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> read_verilog opt_check3.v
yosys> synth -top opt_check3
yosys> opt_clean -purge
yosys> abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> show
```

👉 Expected output = **3-input AND gate** 🎯

image13

---

## 4️⃣ File: `opt_check4.v`

```verilog

module opt_check3 (input a , input b, input c , output y);
	assign y = a?(c?b:0):0;
endmodule
```

- In `opt_check3`, `y` depends on `a` and `c`:
    - If `a = 0 → y = 0`
    - If `a = 1` and `c = 1 → y = b`
    - Else → `y = 0`
- Boolean simplification:
    
    y = (A·(B·C)) = **A·B·C**
    
- ✅ Final circuit → **3-input AND gate**

---

**3. Running the flow in Yosys**

Steps to execute:

1. Invoke Yosys

```verilog
yosys> read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> read_verilog opt_check4.v
yosys> synth -top opt_check4
yosys> opt_clean -purge
yosys> abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> show
```

👉 Expected output = **3-input AND gate** 🎯

image14

---

## 4️⃣ File: `multiple_modules.v`

```verilog
module sub_module2 (input a, input b, output y);
	assign y = a | b;
endmodule

module sub_module1 (input a, input b, output y);
	assign y = a&b;
endmodule

module multiple_modules (input a, input b, input c , output y);
	wire net1;
	sub_module1 u1(.a(a),.b(b),.y(net1));  //net1 = a&b
	sub_module2 u2(.a(net1),.b(c),.y(y));  //y = net1|c ,ie y = a&b + c;
endmodule
```

### 🔎 Analysis

- `sub_module1`: y = a & b
- `sub_module2`: y = a | b
- `multiple_modules`:
    - net1 = a & b
    - y = net1 | c = (a & b) + c

✅ Final simplified equation → **y = (a·b) + c**

---

**3. Running the flow in Yosys**

Steps to execute:

1. Invoke Yosys

```verilog
yosys> read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> read_verilog multiple_modules.v
yosys> flatten multiple_modules 
yosys> synth -top multiple_modules
yosys> opt_clean -purge
yosys> abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> show
```

👉 Expected output = (a·b) + c → AND + OR gate structure ✅

image15

---
🚦 Hold on Cadet Engineer!

Looks like your scrolling finger might need a coffee break ☕.
Day 3’s Sequential Logic Optimisations turned out so heavy that cramming everything into this README.md would feel like trying to fit an elephant 🐘 into a matchbox.

So here’s the deal:

👉 The first half of Sequential Logic Optimisations stays right here in the README.
👉 The second half (with cooler tricks & juicy details 🍉) has moved into a separate file:

## **🔗 Click here to continue the adventure → [Sequential.md]()**

Don’t worry, the story doesn’t end here.
Think of README.md as Season 1 and Sequential.md as the Season 2 you don’t want to miss! 🎬✨

