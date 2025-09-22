# notes

<h1 align="center">🔳 RISC-V SoC Tapeout Program — Week 1️⃣</h1>

<p align="center">
<img  alt="wwek1" src="https://github.com/user-attachments/assets/cb677106-251e-46a9-81f6-9c2e6d0f99c0" width="600" />
</p>


---

<div align="center">

# 🚀 Week 1 — RTL Design & Logic Synthesis

🌟 This is **Week 1** of the **VSD RISC-V SoC Tapeout Program** —

I explored **Verilog RTL design**, learned about **logic synthesis using Yosys**,

and understood the importance of **cell libraries, timing (setup/hold), and faster vs slower cells** in digital design.

</div>

---

## 🎯 Week 1 Objectives

✔️ Learn the basics of **Verilog RTL design** 📝

✔️ Introduction to **Yosys & Logic synthesis** ⚙️

✔️ Understand **cell libraries (.lib) and their role in timing closure** ⏱️

✔️ Explore the difference between **faster vs slower cells** 🔄

✔️ Capture key learnings with practical notes 📚

---

## ✅ Tasks Completed

| 📝 Task | 📌 Description | 🎯 Status |
| --- | --- | --- |
| 1 | Studied **Verilog RTL design fundamentals** | ✅ Done |
| 2 | Explored **Yosys** for logic synthesis | ✅ Done |
| 3 | Understood **why slow cells are needed (HOLD fixing)** | ✅ Done |
| 4 | Compared **Faster vs Slower Cells (Delay, Power, Area trade-offs)** | ✅ Done |
| 5 | Learned how all this ties into the **.lib file** for synthesis | ✅ Done |

---

## 📒 Key Learnings

## Day 1️⃣

- **RTL Design** → Describes circuits at register & logic level (synthesizable Verilog).
- **Yosys** → Converts RTL → Gate-level netlist using `.lib`.
- **Slow Cells** → Prevent hold violations (ensure stable capture).
- **Fast vs Slow Cells**:
    - Fast → Low delay, high area & power.
    - Slow → High delay, low area & power.
- **Balance** → Synthesizer guided by constraints for optimum PPA (Power, Performance, Area).

---

## 🛠️ Tools in Use

- **Yosys** → For RTL to gate-level logic synthesis ⚙️
- **Icarus Verilog** → For RTL simulation 📐
- **GTKWave** → For debugging waveforms 📊

---

👉 Main Repo Link : [[https://github.com/madhavanshree2006/RISC-V-SoC-Tapeout-Program](https://github.com/madhavanshree2006/RISC-V-SoC-Tapeout-Program)]
