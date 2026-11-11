# Endogenous Inherently Secure Microarchitecture & Full-Domain Impedance Convergence

**Baseline Engineering Specification & Formal Sign-off Matrix (v2.0.0)**  
*Initiated by Jianyuan Lab (Endogenous Control Group)*  
*Statutory IP Holder: Shanghai Jianyuan Culture & Art Co., Ltd.*  
*Exclusive Commercial Distributor: Hangzhou Yuemu Network Technology Co., Ltd.*  

[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23717306.svg)](https://doi.org/10.5281/zenodo.23717306)
[![IEEE Standard](https://img.shields.io/badge/Standard-IEEE_1850_SVA-blue.svg)](https://standards.ieee.org/)
[![Automotive Compliance](https://img.shields.io/badge/Compliance-ISO_26262_ASIL--D_%7C_ISO_21434-green.svg)](https://www.iso.org/)
[![SVA Lint](https://github.com/jianyuanlab/eic-soc-formal-baseline/actions/workflows/sva_lint.yml/badge.svg)](https://github.com/jianyuanlab/eic-soc-formal-baseline/actions)

---

## Overview

This repository establishes the open-access formal baseline specifications, SVA linting rules, and AXI4 formal stub interfaces conforming to the **Endogenous Impedance Convergence (EIC v2.0.0)** engineering baseline. 

Designed for mission-critical heterogeneous SoCs (800V SiC/GaN automotive powertrains, autonomous domain controllers, and high-reliability industrial PLCs), the EIC microarchitecture replaces empirical simulation with mathematically proven gate-level invariants aligned with **ISO 26262:2018 (ASIL-D)** and **ISO/SAE 21434:2021 (CAL-4)** sign-off criteria.

## Directory Structure

* `docs/`: Engineering specifications, SVA verification guidelines, and formal mutation sign-off reports (`sample_mutation_killed_report.log`).
* `formal/assertions/`: Universal SVA formal contract models (`EIC-SPEC-01` through `05`) enforcing bounded latency and deadlock elimination.
* `formal/lint/`: Linting constraint rules eliminating simulation race conditions and delta-cycle anomalies.
* `interfaces/`: Parameterized AXI4 bridge wrappers (`axi4_stub`) and normalized execution trace schemas (`ipc_trace_schema.json`, `sample_ipc_trace_nominal.json`, `sample_ipc_trace_mitigation.json`).
* `scripts/`: Headless batch-execution and linting scripts for continuous integration and EDA pre-screening.
* `examples/`: Minimal compilable testbench instantiating AXI4 monitor stubs and binding assertions (`toy_top_tb.sv`).

## Quick Start (Pre-Verification Screening)

To validate the SVA formal assertion contracts against local EDA linting rules:

```bash
# Clone the engineering baseline
git clone [https://github.com/jianyuanlab/eic-soc-formal-baseline.git](https://github.com/jianyuanlab/eic-soc-formal-baseline.git)
cd eic-soc-formal-baseline

# Execute headless SVA linting and race-condition checks
bash scripts/run_sva_lint.sh
```

*Compatible with Cadence JasperGold (2024.09+), Synopsys VC Formal (2024.12+), and Siemens Questa Formal (2024.3+).*

## Formal Mutation Sign-Off Metric

In accordance with ISO 26262-5 Clause 9 formal verification requirements, our contract assertions are screened against comprehensive gate-level mutation injections (Bit-flip, Gate-stuck, and Delay-tamper). A sanitized execution trace proving Mutation Score > 98% is archived in `docs/sample_mutation_killed_report.log`.

## Citation

If your technical evaluation or research references this formal baseline or microarchitectural methodology, please cite the Zenodo archival release:

```bibtex
@misc{jianyuan_eic_v2_2026,
  author       = {{Jianyuan Lab (Endogenous Control Group)}},
  title        = {{Global Industrial Safety Initiative & Formal Sign-off Baseline Specification for Mission-Critical Heterogeneous SoCs (v2.0.0)}},
  year         = 2026,
  publisher    = {Zenodo},
  doi          = {10.5281/zenodo.23717306},
  url          = {[https://doi.org/10.5281/zenodo.23717306](https://doi.org/10.5281/zenodo.23717306)}
}
```

## Official Communications

* **Academic Archival & Formal Inquiries (Jianyuan Lab)**: `jianyuan.one@proton.me`
* **Commercial PoC & Licensing Desk (Hangzhou Yuemu)**: `yuemu.sec@proton.me`

---
*Copyright © 2026 Shanghai Jianyuan Culture & Art Co., Ltd. All rights reserved. Commercial distribution managed exclusively by Hangzhou Yuemu Network Technology Co., Ltd.*
