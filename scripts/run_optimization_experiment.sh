#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$ROOT_DIR/outputs"
RUN_ID="${RUN_ID:-$(date +%Y%m%d_%H%M%S)}"
BIN_DIR="$OUT_DIR/binaries/$RUN_ID"
ASM_DIR="$OUT_DIR/assembly/$RUN_ID"
LOG_DIR="$OUT_DIR/logs/$RUN_ID"
REP_DIR="$OUT_DIR/reports/$RUN_ID"

FLAGS=(O0 O1 O2 O3 Os)
BATCHES="${TIME_BATCHES:-3}"
REPEATS="${TIME_REPEATS:-25}"

ensure_toolchain() {
  if ! command -v gcc >/dev/null 2>&1; then
    echo "GCC is not installed. Install build-essential and retry."
    exit 1
  fi
  mkdir -p "$BIN_DIR" "$ASM_DIR" "$LOG_DIR" "$REP_DIR"
}

avg_times_for_opt() {
  local file="$1"
  local opt="$2"
  awk -v opt="$opt" '
    $1=="OPT" { current=$2; next }
    current==opt && $1=="real" { real+=$2; runs++ }
    END {
      if (runs==0) printf "0\n";
      else printf "%.6f\n", real/runs;
    }
  ' "$file"
}

write_program_report() {
  local set_name="$1"
  local base="$2"
  local time_log="$3"
  local report_file="$4"

  {
    echo "# Report: $set_name / $base"
    echo
    echo "## Optimization Levels"
    echo "- O0, O1, O2, O3, Os"
    echo
    echo "## Runtime (avg of 3 runs)"
    echo "| Level | real(s) |"
    echo "|---|---:|"
    for opt in "${FLAGS[@]}"; do
      local r
      r="$(avg_times_for_opt "$time_log" "$opt")"
      echo "| $opt | $r |"
    done
    echo
    echo "## Binary Size (bytes)"
    echo "| Level | Bytes |"
    echo "|---|---:|"
    for opt in "${FLAGS[@]}"; do
      local exe="$BIN_DIR/$set_name/$base/${base}_${opt}"
      local bytes
      bytes="$(stat -c '%s' "$exe")"
      echo "| $opt | $bytes |"
    done
  } > "$report_file"
}

process_set() {
  local set_name="$1"
  local src_dir="$2"

  local set_bin="$BIN_DIR/$set_name"
  local set_asm="$ASM_DIR/$set_name"
  local set_log="$LOG_DIR/$set_name"
  local set_rep="$REP_DIR/$set_name"
  mkdir -p "$set_bin" "$set_asm" "$set_log" "$set_rep"

  local time_csv="$REP_DIR/${set_name}_time_results.csv"
  local size_csv="$REP_DIR/${set_name}_size_results.csv"
  printf "program,opt,avg_real\n" > "$time_csv"
  printf "program,opt,text,data,bss,dec,hex,bytes\n" > "$size_csv"

  shopt -s nullglob
  local sources=("$src_dir"/*.c)
  if [ "${#sources[@]}" -eq 0 ]; then
    echo "No C files found in: $src_dir"
    return
  fi

  for src in "${sources[@]}"; do
    local base
    base="$(basename "$src" .c)"

    local prog_bin="$set_bin/$base"
    local prog_asm="$set_asm/$base"
    local prog_log="$set_log/$base"
    mkdir -p "$prog_bin" "$prog_asm" "$prog_log"

    local time_log="$prog_log/time_results.txt"
    local compile_log="$prog_log/compile_commands.txt"
    : > "$time_log"
    : > "$compile_log"

    for opt in "${FLAGS[@]}"; do
      local exe="$prog_bin/${base}_${opt}"
      local asm="$prog_asm/${base}_${opt}.s"

      echo "gcc '$src' -$opt -o '$exe'" >> "$compile_log"
      gcc "$src" -"$opt" -o "$exe"

      echo "gcc '$src' -$opt -S -o '$asm'" >> "$compile_log"
      gcc "$src" -"$opt" -S -o "$asm"

      for run in $(seq 1 "$BATCHES"); do
        local runtime_file="$prog_log/runtime_${opt}_run${run}.txt"
        echo "OPT $opt RUN $run" >> "$time_log"
        local start_ns end_ns elapsed_ns real_per_run
        : > "$runtime_file"
        start_ns="$(date +%s%N)"
        for rep in $(seq 1 "$REPEATS"); do
          if [ "$rep" -eq 1 ]; then
            "$exe" > "$runtime_file" 2>&1
          else
            "$exe" > /dev/null 2>&1
          fi
        done
        end_ns="$(date +%s%N)"
        elapsed_ns="$((end_ns - start_ns))"
        real_per_run="$(python3 - <<PY
elapsed_ns = $elapsed_ns
repeats = $REPEATS
print(f"{elapsed_ns / 1_000_000_000 / repeats:.9f}")
PY
)"

        printf "real %s\n" "$real_per_run" >> "$time_log"
        printf "user 0.000000000\n" >> "$time_log"
        printf "sys 0.000000000\n" >> "$time_log"
        printf "elapsed_ns %s\n" "$elapsed_ns" > "$prog_log/time_${opt}_${run}.txt"
        echo >> "$time_log"
      done

      local avg_real
      avg_real="$(avg_times_for_opt "$time_log" "$opt")"
      printf "%s,%s,%s\n" "$base" "$opt" "$avg_real" >> "$time_csv"

      local size_line
      size_line="$(size "$exe" | awk 'NR==2{print $1","$2","$3","$4","$5}')"
      local bytes
      bytes="$(stat -c '%s' "$exe")"
      printf "%s,%s,%s,%s\n" "$base" "$opt" "$size_line" "$bytes" >> "$size_csv"
    done

    write_program_report "$set_name" "$base" "$time_log" "$set_rep/${base}_report.md"
  done
}

main() {
  ensure_toolchain
  ulimit -s unlimited || true

  process_set "original_11" "$ROOT_DIR/original 11/source"
  process_set "user_8" "$ROOT_DIR/user 8/source"

  echo "Run complete."
  echo "Run ID: $RUN_ID"
  echo "Binaries: $BIN_DIR"
  echo "Assembly: $ASM_DIR"
  echo "Logs: $LOG_DIR"
  echo "Reports: $REP_DIR"
}

main "$@"
