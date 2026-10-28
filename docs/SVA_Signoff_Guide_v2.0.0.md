# SystemVerilog Assertions (SVA) Formal Sign-off & Verification Guide

**Specification Baseline**: v2.0.0  
**Verification Framework**: Formal Property Checking (FPC) & Mutation Coverage  
**Initiator**: Jianyuan Lab (Endogenous Control Group)  

---

## 1. Formal Sign-off Hard Gate Matrix (v2.0.0 Baseline)

| Rule ID | Gate Definition | Invariant Formal Specification | Severity | Coverage |
| :--- | :--- | :--- | :--- | :--- |
| **SVA-LINT-01** | Unbounded Delay Blocking | Forbid unbounded operator ##[0:$]; enforce finite bound k <= N_cycles. | Blocking | Universal Baseline |
| **SVA-LINT-02** | Reset Contract Enforcement | All properties must explicitly bind to active-low reset: disable iff (!rst_n). | Blocking | Universal Baseline |
| **SVA-LINT-03** | Preponed Phase Sampling | Variable sampling via $sampled in preponed clock phases. | Blocking | Universal Baseline |
| **SIG-GATE-01** | Global Deadlock Elimination | Model checkers prove absence of circular wait across FSM transitions. | Sign-off Gate | EIC-SPEC-02/03 |
| **SIG-GATE-02** | Cross-Coverage Threshold | Achieve 100% cross-coverage across assertion meshes and AXI handshakes. | Sign-off Gate | Universal Baseline |
| **SIG-GATE-03** | Formal Mutation Score | Mutation score under fault injection must exceed 95%. | Sign-off Gate | Universal Baseline |
| **SIG-GATE-04** | Bounded Instruction Auth | Authenticators trap invalid injections within T_auth <= 2 cycles. | Sign-off Gate | EIC-SPEC-01 |
| **SIG-GATE-05** | Decoy Isolation Contract | Shadow bus redirection completes within T_isolate <= 4 cycles. | Sign-off Gate | EIC-SPEC-02 |
| **SIG-GATE-06** | Bounded OOB Safe Reload | Clear CDC synchronizers and FIFO drain within deterministic cycles. | Sign-off Gate | EIC-SPEC-03 |
| **SIG-GATE-07** | Side-Channel Entropy Bound | Current injection correlation satisfies R_corr < epsilon_threshold. | Sign-off Gate | EIC-SPEC-04 |
| **SIG-GATE-08** | PUF Drift Calibration | Fuzzy extractor reconstruction failure probability P_fail < 10^-9. | Sign-off Gate | EIC-SPEC-05 |

---

## 2. Mutation Analysis Sign-off Command Reference
To verify zero false-passes and dead logic:

    bash scripts/run_mutation_audit.sh --matrix=v2.0.0 --threshold=95
