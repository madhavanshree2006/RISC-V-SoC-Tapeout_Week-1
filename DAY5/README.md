<h1 align="center">🌟 RISC-V SoC Tapeout – Week 1️⃣</h1>
<br><br>

<h2 align="center">🚀 Day 4 - Optimization in synthesis</h2>
<br>


# 🌟 SKY130RTL D5SK1 L1 – IF & CASE Constructs (Part 1)

## 1️⃣ IF Statements – Priority Logic

- **Purpose:** Used to create **priority logic** in hardware.
- **Syntax:**

```verilog
if (cond1) begin
    // code
end else if (cond2) begin
    // code
end else begin
    // code
end
```

Structure of the if-statement 

image1

- **Priority Behavior:**
    - `condition1` → **highest priority**
    - Only when `condition1` fails, `condition2` is checked
    - Only when all previous conditions fail, the `else` portion executes

---

### 🔹 Hardware Mapping

- C1 → Logic for condition1
- C2 → Logic for condition2
- C3 → Logic for condition3
- E → Else portion, executes only if all previous conditions fail

**Key point:** If a higher priority condition is met, lower conditions are ignored. ✅

---

## 2️⃣Danger with IF – Inferred Latches ⚠️

- **Problem:** Incomplete `if` statements can create **inferred latches**.
- **Example:**

```verilog
if (condition1)
    y = a;
else if (condition2)
    y = b;
// No else!
```

image2

image3

### 🔹 What Happens in Hardware:

- If **condition1 and condition2 are false**, the output `y` is **not defined**.
- Tool infers a **latch** to hold the previous value of `y`.
- This is called an **inferred latch** due to incomplete coding.

**Diagram:**

- Enable = condition1 OR condition2
- Output `y` retains previous value when both conditions fail

**⚠️ Warning:**

- Inferred latches are usually **undesired** in combinational logic.
- Only use intentionally for sequential circuits like counters.

---

# 🌟 SKY130RTL D5SK1 L2 – IF & CASE Constructs (Part 2)

---

## 1️⃣ Incomplete IF – When Is It Okay? ✅ / ❌

- **Example:** 3-bit counter

```verilog
always @(posedge clock or posedge reset) begin
    if (reset)
        count <= 3'b000;
    else if (enable)
        count <= count + 1;
end
```

image4

- **Behavior:**
    - Counter **increments only if `enable` is high**
    - If `enable` is low → `count` retains previous value (latches naturally)
- **Key Insight:**
    - In **sequential circuits**, incomplete `if` is fine ✅
    - In **combinational circuits**, incomplete `if` can cause **inferred latches** ❌

**Rule:** Always think about **hardware behavior** when writing code 🛠️

---

## 2️⃣ CASE Statements – Introduction

- **Used inside** `always` blocks
- **Variable to assign:** must be a `reg`
- **Syntax:**

```verilog
reg y;
always @(*) begin
    case (select)
        2'b00: begin
				       y = c1;          
				       end
        2'b01: begin
                y = c2 
               end
        // other cases...
    endcase
end
```

image5

- **Analogous to:** `switch-case` in C/C++ ✅
- **Hardware Mapping:**
    - Infers a **MUX** (e.g., 4x1 MUX for a 2-bit `select`)
    - Each case corresponds to a **MUX input selection**

---

## 3️⃣ Dangers of CASE Statements ⚠️

### a) Incomplete Case

- **Problem:** Not covering all possible inputs → **inferred latches**
- **Example:**
    - `select` is 2-bit → 4 possible combinations (`00`, `01`, `10`, `11`)
    - If only `00` and `01` are coded → `10` and `11` are **undefined** → inferred latch

### b) Solution: `default` Case ✅

- Always include `default` to **avoid inferred latches**

image6

- **Example:**

```verilog

reg [1:0] sel;
always @(*) 
begin
    case (select)
        2'b00: begin
				       y = c1;          
				       end
        2'b01: begin
                y = c2 
               end
        // other cases...
        default: y = default_val; // default case to prevent latches
    endcase
end
```

- **Effect:** Any unspecified value of `select` triggers `default` → no latches inferred

---

## 4️⃣ Key Takeaways

- **IF Statements:**
    - Create **priority logic**
    - Incomplete IF → inferred latch in combinational logic ⚠️
    - Sequential logic (like counters) can safely use incomplete IF ✅
- **CASE Statements:**
    - Must assign **reg variables**
    - Incomplete CASE → inferred latch ⚠️
    - Always use **default** to prevent undesired latches ✅

> **Hardware Mindset:** Always visualize **hardware translation** when coding Verilog 🛠️
> 

---

# 🌟 SKY130RTL D5SK1 L3 – IF & CASE Constructs (Part 3)

---

## 1️⃣ Partial Assignments in CASE ⚠️

- **Scenario:** Controlling multiple outputs (`X` and `Y`) in a `case`
- **Example Code:**

```verilog
reg X, Y;
reg [1:0] select;

always @(*) begin
    case (select)
        2'b00: begin 
				        X = A; 
				        Y = B; 
				        end
        2'b01: begin 
				        X = C; 
				        end      // Y not assigned!
            default:
             begin
		             X = D; 
		             Y = B; 
		         end
    endcase
end
```

- **Problem:**
    - When `select = 2'b01`, `Y` is **not assigned** → inferred latch created
    - Default does **not cover this partial assignment** → latch inferred for missing outputs

image7

- **Rule:** ✅
    - **Always assign all outputs in every segment** of the `case`
    - Avoid leaving some outputs unassigned → prevents inferred latches

---

## 2️⃣ IF vs CASE – Priority & Execution 🔄

- **IF-ELSE Statement:**
    - Provides **clear priority**
    - Only the **first matched condition executes**
    - Execution **stops immediately** after match
- **CASE Statement:**
    - Executes **sequentially from top to bottom**, like C `switch`
    - Overlapping cases can **match multiple segments** → unpredictable outputs
- **Example of Dangerous Overlapping CASE:**

```verilog
case (select)
    2'b00: ...
    2'b01: ...
    2'b10: ...
    2'b1?: ...  // MSB=1, LSB can be anything → overlaps with 2'b10 and 2'b11
endcase
```

- **Problem:**
    - For `select = 2'b10` → matches `2'b10` and `2'b1?`
    - Output becomes **unpredictable**
- **Key Rule:** ⚠️
    - Avoid overlapping case statements
    - Ensure each input combination matches **exactly one case**

---

## 3️⃣ Summary of CASE Caveats ✅

1. **Incomplete CASE → inferred latches**
2. **Partial assignments → inferred latches**
3. **Overlapping CASE → unpredictable outputs**
4. **Default case mandatory** to cover all unspecified conditions

---

# 🌟 **SKY130RTL D5SK2 L1 Lab Incomplete IF part1**

---

## 1️⃣ Lab Files & Setup 🗂️

- **Files location:** All `.v` files in the folder
- **Examples Covered:**
    1. Incomplete IF
    2. Incomplete CASE
    3. Partial assignments in CASE
- **Simulation Tool:** Iverilog
- **Synthesis Tool:** Yosys (or Synopsys-like tools)

---

## 2️⃣ Incomplete IF Example

- **RTL Design (incomp_if.v)**

```verilog
module incomp_if (input i0 , input i1 , input i2 , output reg y);
always @ (*)
begin
	if(i0)
		y <= i1;
end
endmodule
```

- **Inputs/Outputs:**
    - Inputs: `i0`, `i1`, `i2` (i2 unused)
    - Output: `y` (register)

---

### 3️⃣ Hardware Mapping 🛠️

- **IF always translates into a MUX**
- **Incomplete ELSE:**
    - Creates **inferred D latch**
    - Enable = `i0`
    - When `i0` is high → `y = i1`
    - When `i0` is low → `y` **latches previous value**

image 8

- **Behavior Summary:**
    
    
    | Condition | Output (Y) |
    | --- | --- |
    | i0 = 1 | Y follows I1 |
    | i0 = 0 | Y retains previous value (latched) |
- ✅ This is **expected latch behavior** for incomplete IF

---

### 4️⃣ Simulation Results 🖥️

- **Simulation using Iverilog:**
    
    ```bash
    iverilog incomp_if.v tb_incomp_if.v
    ./a.out
    gtkwave  tb_incomp_if.vcd
    ```
    
    image9
    
    - Observations in GTKWave:
        - When `i0` = 1 → `y` follows `i1`
        - When `i0` = 0 → `y` remains constant at last value
    - Confirms **latching behavior due to incomplete IF**

---

### 5️⃣ Synthesis Behavior ⚡

- **Synthesis using Yosys:**

```
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog incomp_if.v
synth -top incomp_if
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

image10

- **Observation:**
    - Tool infers **D latch**
    - Enable = `i0`, D input = `i1`, Q = `y`
    - Even though intended was a **MUX**, the incomplete IF causes **inferred latch**
- **Key Warning:** ⚠️
    - **Incomplete IF → inferred latch**
    - Danger: You may **unintentionally introduce sequential elements** in combinational logic

---

# 🌟 SKY130RTL D5SK2 L1 Lab Incomplete IF part2

### 1️⃣ RTL Code Behavior `incomp_if2.v`

- **Inputs:** `i0`, `i1`, `i2`
- **Output:** `y` (register variable)

**Conceptual Logic:**

- `always` with **incomplete IF**:
    
    ```verilog
    
    module incomp_if2 (input i0 , input i1 , input i2 , input i3, output reg y);
    always @ (*)
    begin
    	if(i0)
    		y <= i1;
    	else if (i2)
    		y <= i3;
    
    end
    endmodule
    ```
    
- **Interpretation:**
    - When `i0` = 1 → `y` follows `i1` ✅
    - When `i0` = 0 → `y` **latches previous value** 🔒
- This effectively models a **D latch** with `i0` as the enable signal

image11

---

### 2️⃣ Simulation Observations 🖥️

```bash
iverilog incomp_if2.v tb_incomp_if2.v
./a.out
gtkwave  tb_incomp_if2.vcd
```

- **Waveform Analysis:**

image12

- When `i0` = 1 → `y` follows `i1`
- When `i0` = 0 → `y` holds previous value (either 1 or 0) 🔒
- Observed behavior matches the D latch model

---

### 3️⃣ Synthesis Observations ⚙️

- Tool: **Uses**
    
    ```bash
    read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    read_verilog incomp_if2.v
    synth -top incomp_if2
    abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    show
    ```
    

image13

- **Logic Observed:**
    - **Latch inferred** 🔒
    - D input: `i1`
    - Enable: `i0`
    - Q output: `y`
- **Key Point:** Even though a combinational logic was intended (MUX), **incomplete IF caused latch inference**

---

# 🌟 SKY130RTL D5SK3 L1 Lab Incomplete Overlapping Case part1

---

### 1️⃣ RTL Code Behavior `incomp_case.v`

- **Inputs:** `i0`, `i1`, `i2` (select line)
- **Output:** `y`

**Conceptual Logic:**

```verilog
module incomp_case (input i0 , input i1 , input i2 , input [1:0] sel, output reg y);
always @ (*)
begin
	case(sel)
		2'b00 : y = i0;
		2'b01 : y = i1;
	endcase
end
endmodule
```

- **Interpretation:**

image 14

- `select = 00` → `y` follows `i0` ✅
- `select = 01` → `y` follows `i1` ✅
- `select = 10 or 11` → `y` **latches previous value** 🔒
- This effectively models a **D latch** for unspecified case conditions

---

### 2️⃣ Functional Simulation 🖥️

```bash
iverilog incomp_case.v tb_incomp_case.v
./a.out
gtkwave  tb_incomp_case.vcd
```

- **Waveform Observations:**

image15

| Select (`{i1,i0}`) | Output `y` Behavior | Notes |
| --- | --- | --- |
| 00 | Follows `i0` ✅ | Defined in case statement |
| 01 | Follows `i1` ✅ | Defined in case statement |
| 10, 11 | Latches previous value 🔒 | Incomplete case → inferred latch |
- Behavior aligns with expected **latching action** for incomplete case

---

### 3️⃣ Synthesis Observations ⚙️

- Tool: **Uses yosys**

```bash
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog incomp_case.v
synth -top incomp_case
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

image16

- **Logic Observed:**
    - **Latch inferred** 🔒 driving output `y`
    - Enable condition: `select[1]'` (inverted MSB of select)
    - MUX logic implements remaining specified cases
- **Key Point:** Incomplete case leads to **latch inference**, even if unintended

---

# 🌟 SKY130RTL D5SK3 L1 Lab Incomplete Overlapping Case — Part 2

### ✅ Key Idea: Adding `default` Changes Everything

To understand the impact, the **only change** made in the RTL was adding a `default` case. That small update turns the behavior from **latch-based** to **pure combinational** ✅

---

### 1️⃣ RTL Behavior with `default`

When `default` is added:

- **Select = 00** → `y = i0`
- **Select = 01** → `y = i1`
- **Select = 10 or 11** → `y = i2` ✅ (because of the default)

💡 Since all `select` values are covered (0,1,2,3), **no latch is inferred**.

image17

---

### 2️⃣ Simulation Flow 🖥️

```bash
iverilog comp_case.v tb_comp_case.v
./a.out
gtkwave tb_comp_case.vcd
```

✅ **Simulation Result:**

image18

- `sel = 00` → follows `i0`
- `sel = 01` → follows `i1`
- `sel = 10` or `11` → follows `i2`
- **No holding of past value → no latch behavior** 🎉

---

### 3️⃣ Synthesis Result ⚙️

Commands:

```bash
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog comp_case.v
synth -top comp_case
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

✅ Output:

iamge19

- Only **AND, OR, NOT, MUX cells**
- ❌ **No latch inferred**
- Clean combinational logic
- Equivalent to a **4:1 multiplexer**

---

### 🔍 Why No Latch This Time?

Because `default` **handles the missing select cases**, covering:

| Select | Output |
| --- | --- |
| 00 | i0 ✅ |
| 01 | i1 ✅ |
| 10 | i2 ✅ |
| 11 | i2 ✅ |

Nothing is left undefined ➝ no latching 🔓

---

# 🌟 SKY130RTL D5SK3 L3 Lab — Incomplete & Overlapping Case (Part 3)

### ✅ Focus: Partial Case Assign & Overlapping Case Pitfalls

We now explore:

- ✅ How **only one output** may infer a latch
- ✅ How **default doesn’t always save you**
- ⚠️ What happens with **overlapping case items**

---

## 1️⃣ Synthesis of `partial_case_assign.v`

RTL

```bash
module partial_case_assign (input i0 , input i1 , input i2 , input [1:0] sel, output reg y , output reg x);
always @ (*)
begin
	case(sel)
		 2'b00 : begin
			y = i0;
			x = i2;
			end
		2'b01 : y = i1;
		default : begin
		           x = i1;
			   y = i2;
			  end
	endcase
end
endmodule
```

Only output **`x`** has an incomplete case — so only **one latch** is inferred ✅

```bash
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog partial_case_assign.v
synth -top partial_case_assign
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

image20

### 🔍 Observation:

image21

- ✅ **`y` has NO latch** → fully defined
- 🔒 **`x` has a latch** due to missing assignments

### 🧠 Latch Enable Logic (from synthesis)

From the inferred NAND + INV structure:

```
Enable = sel1 + sel0'
```

Exactly what we had predicted earlier 🎯

You saw this from:

- A → `sel1_bar`
- B → `sel0`
- NAND + DeMorgan ➝ `sel1 + sel0'`

fPerfect alignment with expectations ✅

---

## 2️⃣ Overlapping `case` — The REAL Danger ⚠️

File: `bad_case.v`

Here’s the issue:

```verilog
2’b?0 → y = i0
2’b?0 → y = i1   // overlapping
2’b10 → y = i2
2’b1? → y = i3   // overlapping with above

```

Because `case` is **not mutually exclusive**, overlapping patterns create **confusion** in both:

- ✅ Simulation
- ✅ Synthesis

---

## 3️⃣ Simulation of `bad_case.v`

```bash
iverilog bad_case.v tb_bad_case.v
./a.out
gtkwave tb_bad_case.vcd
```

image22

### 😵 What Happened?

- When `select = 11`, output **does not follow** `i2` or `i3`
- Instead, it **randomly latches a previous value** (e.g., `1`)
- Simulator gets confused due to **multiple matching case items**

✅ This is **simulation vs synthesis mismatch** territory — very dangerous!

---

## 4️⃣ Why the Confusion?

- `case` **does not stop** after the first match
- All patterns are evaluated unless `priority` or `unique` is used
- Overlaps like `2’b10` and `2’b1?` trigger **unexpected results**

### ❌ Unlike `if-else`, `case` is NOT exclusive by default.

---

# 🌟 SKY130RTL D5SK3 L4 – Overlapping Case Behavior (Part 4)

### ✅ Objective

Understand how **overlapping `case` conditions** behave differently in:

- RTL Simulation 🧪
- Gate-Level Simulation (GLS) ⚙️
- Synthesis 🏗️

---

## 1️⃣ Synthesis – No Latches, but Overlap Issues

```bash
read_verilog bad_case.v
synth -top bad_case
```

✅ Observation:

image23

- No missing case items → **No inferred latches**
- BUT overlapping case branches still create **functional ambiguity**

✔️ Cell profile confirms:

- **Only combinational logic**
- **Zero latches** inferred

---

## 2️⃣ Technology Mapping & Netlist Generation

```bash
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog bad_case.v
synth -top bad_case
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
write_verilog -noattr bad_case_net.v 
show
```

image24

🔍 Everything still appears normal — but overlap is a hidden hazard.

---

## 3️⃣ Gate-Level Simulation (GLS)

```bash
# Reading models, netlist, and TB
iverilog ../my_lib/verilog_model/primitives.v \
../my_lib/verilog_model/sky130_fd_sc_hd.v \
bad_case_net.v \
tb_bad_case.v -o a.out

./a.out
gtkwave tb_bad_case.vcd
```

image25

### ✅ GLS Behavior (Correct Output)

| `select` | Output Driven ✅ |
| --- | --- |
| 00 | `i0` |
| 01 | `i1` |
| 10 | `i2` |
| 11 | `i3` |

👍 No latching

👍 No confusion

👍 Matches expected truth mapping

---

## ⚠️ RTL Simulation vs GLS – Big Difference!

In **RTL simulation**, when overlapping patterns existed:

- `y` got stuck at a previous value ❌
- Tool couldn’t decide which assignment to pick
- Caused a latch-like effect

In **GLS**, the resolved logic eliminated the ambiguity ✅

---

## 🛑 Key Warning: Avoid Overlapping Case Items

Even with:

✅ Full case coverage

✅ No missing defaults

✅ No latches inferred

You can STILL end up with:

- ❗ Simulation vs Synthesis mismatch
- ❗ Unpredictable behavior across tools
- ❗ Debugging nightmares

---

## ✅ Golden Rule for Case Statements

✔ All `case` branches must be **mutually exclusive**

✔ Avoid wildcards (`?`, ranges, overlaps) unless using `priority`/`unique case`

✔ Always verify behavior in both RTL and GLS

---
🚦 Hold on Cadet Engineer!

Looks like your scrolling finger might need a coffee break ☕. Day 3’s Sequential Logic Optimisations turned out so heavy that cramming everything into this README.md would feel like trying to fit an elephant 🐘 into a matchbox.

So here’s the deal:

👉 The first half of Sequential Logic Optimisations stays right here in the README. 👉 The second half (with cooler tricks & juicy details 🍉) has moved into a separate file:

## 🔗 Click here to continue the adventure → **[Loops.md](https://github.com/madhavanshree2006/RISC-V-SoC-Tapeout_Week-1/blob/main/DAY5/Loops.md)**


Don’t worry, the story doesn’t end here. Think of README.md as Season 1 and Sequential.md as the Season 2 you don’t want to miss! 🎬✨
