# GCC Optimization Experiment Project

This repository is a reproducible GCC optimization study with two code sets:

- **Original 11** programs (baseline academic optimization examples)
- **User 8** programs (additional team/user-designed optimization cases)

It compiles each program with multiple GCC optimization levels, runs timing experiments, generates assembly, collects binary sizes, and writes structured outputs for analysis/reporting.

---

## What this project contains

### Goal
Measure and compare the effect of GCC optimization levels on runtime and binary size, and preserve artifacts (binaries, assembly, logs, CSV reports) in a consistent structure.

### Optimization levels tested

- `-O0`
- `-O1`
- `-O2`
- `-O3`
- `-Os`

### Code sets

- `original 11/source` → 11 baseline C programs
- `user 8/source` → 8 additional C programs

---

## Repository structure

```text
.
├── README.md
├── CD REPORT TEAM NO.4.md
├── original 11/
│   ├── docs/
│   └── source/
├── user 8/
│   ├── docs/
│   └── source/
├── scripts/
│   └── run_optimization_experiment.sh
└── outputs/
    ├── binaries/
    ├── assembly/
    ├── logs/
    └── reports/
```

### Output structure per run

The runner writes into timestamped run folders to avoid overwrite/lock issues:

```text
outputs/
├── binaries/<RUN_ID>/<set_name>/<program>/<program>_<Olevel>
├── assembly/<RUN_ID>/<set_name>/<program>/<program>_<Olevel>.s
├── logs/<RUN_ID>/<set_name>/<program>/
│   ├── compile_commands.txt
│   ├── time_results.txt
│   ├── time_<Olevel>_<batch>.txt
│   └── runtime_<Olevel>_run<batch>.txt
└── reports/<RUN_ID>/
    ├── original_11_time_results.csv
    ├── original_11_size_results.csv
    ├── user_8_time_results.csv
    └── user_8_size_results.csv
```

---

## Requirements

## 1) OS
- Linux (native or WSL Ubuntu recommended)

## 2) Toolchain
- `gcc`
- `bash`
- `awk`
- `size` (from binutils, usually present with GCC toolchain)
- `python3` (used by timing calculation inside the script)

## 3) Install commands (Ubuntu/WSL)

```bash
sudo apt update
sudo apt install -y build-essential python3
```

Verify:

```bash
gcc --version
python3 --version
```

---

## Quick start (after clone)

From repository root:

```bash
chmod +x "scripts/run_optimization_experiment.sh"
./scripts/run_optimization_experiment.sh
```

The script prints:
- `Run ID`
- output paths for binaries, assembly, logs, reports

---

## Script reference

## `scripts/run_optimization_experiment.sh`

### What it does
For every `.c` file in both source folders:
1. Compiles with `-O0 -O1 -O2 -O3 -Os`
2. Emits assembly for each optimization level
3. Runs timing batches and computes average `real` time
4. Collects `size` metrics
5. Writes per-program logs + per-set CSV summaries

### Timing method
- Uses high-resolution wall-clock timing (`date +%s%N`)
- Executes each binary multiple times per batch
- Stores averaged `avg_real`
- `avg_user` and `avg_sys` are intentionally **not** included (not recorded in this method)

### Configurable environment variables

You can override these at runtime:

- `TIME_BATCHES` (default: `3`) → number of timing batches per optimization level
- `TIME_REPEATS` (default: `25`) → executions per batch
- `RUN_ID` (default: timestamp like `YYYYMMDD_HHMMSS`) → output folder ID

Example:

```bash
TIME_BATCHES=5 TIME_REPEATS=100 RUN_ID=benchmark_v2 ./scripts/run_optimization_experiment.sh
```

---

## Understanding generated reports

## Results snapshot

Latest captured run in this repository:

- `RUN_ID`: `20260303_233024`
- Time summary (Original 11): `outputs/reports/20260303_233024/original_11_time_results.csv`
- Size summary (Original 11): `outputs/reports/20260303_233024/original_11_size_results.csv`
- Time summary (User 8): `outputs/reports/20260303_233024/user_8_time_results.csv`
- Size summary (User 8): `outputs/reports/20260303_233024/user_8_size_results.csv`

Sample per-program artifacts from the same run:

- Report: `outputs/reports/original_11/11_loop_fusion_large_report.md`
- Runtime log: `outputs/logs/20260303_233024/original_11/11_loop_fusion_large/time_results.txt`
- Assembly output: `outputs/assembly/20260303_233024/original_11/11_loop_fusion_large/11_loop_fusion_large_O3.s`

> Note: Older non-timestamped report files may exist from earlier script versions. Use the timestamped run folder as the canonical snapshot.

## Time CSV format

`outputs/reports/<RUN_ID>/*_time_results.csv`

Columns:
- `program`
- `opt`
- `avg_real`

## Size CSV format

`outputs/reports/<RUN_ID>/*_size_results.csv`

Columns:
- `program`
- `opt`
- `text`
- `data`
- `bss`
- `dec`
- `hex`
- `bytes`

---

## Re-running experiments

Each run creates a new `<RUN_ID>` folder, so old runs remain intact.

To run again:

```bash
./scripts/run_optimization_experiment.sh
```

To use a custom label:

```bash
RUN_ID=my_run_01 ./scripts/run_optimization_experiment.sh
```

---

## Adding new programs

1. Add a new `.c` file to either:
   - `original 11/source`
   - `user 8/source`
2. Re-run script:

```bash
./scripts/run_optimization_experiment.sh
```

No script changes are needed for standard additions.

---

## Troubleshooting

## Permission denied on outputs
If a report file is open/locked by another process, write may fail. This project avoids most conflicts via timestamped run folders. If needed, close file handles and run again with a new `RUN_ID`.

## GCC not found
Install build tools:

```bash
sudo apt install -y build-essential
```

## Very small/near-zero timings
For tiny programs, increase repetitions:

```bash
TIME_REPEATS=200 TIME_BATCHES=5 ./scripts/run_optimization_experiment.sh
```

## Stack/memory issues on large array programs
In constrained environments, raise stack before run:

```bash
ulimit -s unlimited
./scripts/run_optimization_experiment.sh
```

---

## Related report

Detailed written analysis is in:

- `CD REPORT TEAM NO.4.md`

---


