<h1 align="center">🔳 RISC-V SoC Tapeout Program — Week 1️⃣</h1>

<p align="center">
<img  alt="wwek1" src="https://github.com/user-attachments/assets/cb677106-251e-46a9-81f6-9c2e6d0f99c0" width="600" />
</p>


---

<div align="center">

# 🚀 Week 1 — RTL Design & Logic Synthesis

🌟 This is **Week 1** of the **VSD RISC-V SoC Tapeout Program** —

I explored **Verilog RTL design**, learned about **simulation (Icarus + GTKWave)**,

understood **logic synthesis using Yosys**,

and studied the importance of **cell libraries, timing (.lib), and faster vs slower cells** in digital design.

</div>

---

## 🎯 Week 1 Objectives

✔️ Introduction to **Verilog RTL design** 📝

✔️ Hands-on with **Icarus Verilog & GTKWave** for simulation/debugging 📐📊

✔️ Explore **Yosys** for RTL → Gate-level synthesis ⚙️

✔️ Understand **cell libraries (.lib) and their role in timing closure** ⏱️

✔️ Learn about **Hierarchical vs Flat synthesis** 🏗️

✔️ Compare **Flop coding styles & optimizations** 🔄

✔️ Capture **combinational & sequential optimizations** 🧩

---

## ✅ Tasks Completed

| 📝 Task | 📌 Description | 🎯 Status |
| --- | --- | --- |
| 1 | Studied **Verilog RTL design fundamentals** | ✅ Done |
| 2 | Wrote and ran testbenches using **Icarus Verilog** | ✅ Done |
| 3 | Debugged waveforms using **GTKWave** | ✅ Done |
| 4 | Explored **Yosys** for logic synthesis | ✅ Done |
| 5 | Understood **cell libraries (.lib)** and timing concepts | ✅ Done |
| 6 | Analyzed **Hierarchical vs Flat synthesis** | ✅ Done |
| 7 | Learned different **Flop coding styles and optimizations** | ✅ Done |
| 8 | Explored **Combinational & Sequential Logic Optimizations** | ✅ Done |

---

## 📒 Key Learnings

### 📌 Day 1 — Verilog RTL Design & Simulation

- **RTL Design** → Circuits at register & logic level (synthesizable Verilog).
- **Icarus Verilog** → For compiling + simulating designs.
- **GTKWave** → To visualize & debug waveform outputs.

### 📌 Day 2 — Logic Synthesis & Timing Libraries

- **Yosys** → Converts RTL → Gate-level netlist.
- **.lib Files** → Contain timing, power, and area info of standard cells.
- **Hierarchical vs Flat Synthesis**:
    - Hierarchical → preserves design hierarchy.
    - Flat → merges logic for aggressive optimization.

### 📌 Day 3 — Optimizations in Synthesis

- **Slow Cells** → Prevent hold violations (ensure stability).
- **Fast Cells** → Reduce setup delay, but increase power & area.
- **Optimization Balance** → Synthesizer chooses cells for optimum PPA (Power, Performance, Area).
- **Combinational Optimization** → Removes redundant gates.
- **Sequential Optimization** → Removes unused flops/outputs.

## 🛠️ Tools in Use

- **Yosys** → For RTL to gate-level logic synthesis ⚙️
- **Icarus Verilog** → For RTL simulation 📐
- **GTKWave** → For debugging waveforms 📊

---

👉 Main Repo Link : [[https://github.com/madhavanshree2006/RISC-V-SoC-Tapeout-Program](https://github.com/madhavanshree2006/RISC-V-SoC-Tapeout-Program)]
