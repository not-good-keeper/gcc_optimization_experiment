**COMPREHENSIVE GCC CODE OPTIMIZATION ANALYSIS**

**Author:** 

Dhrusheek Rishi Menon (23CSE716)

Keertan Vasani (23CSE723)

Nethi Kushala Kumar (23CSE735)

Yalamanchi Kushal (23CSE766)

**1\. Introduction**

Compiler optimization is the phase in which the compiler transforms source code to improve execution speed, reduce binary size, or simplify control flow without changing program semantics.

GCC optimization levels used in this study:

* **O0** – Disables most optimizations; favors debugging.

* **O1** – Enables low-risk optimizations such as dead code elimination and simple propagation.

* **O2** – Enables a broad, production-oriented optimization set.

* **O3** – Extends O2 with aggressive transformations including inlining and loop transformations.

* **Os** – Optimizes for code size while retaining reasonable performance.

Technically relevant transformations observed in this study include:

* Constant Folding  
* Constant Propagation  
* Dead Code Elimination  
* Branch Elimination  
* Common Subexpression Elimination  
* Strength Reduction  
* Induction Variable Simplification  
* Loop-Invariant Code Motion  
* Frequency Reduction  
* Loop Fusion (Loop Jamming)  
* Function Inlining  
* Loop Unrolling

**2\. Experiment Setup**

Environment:

* WSL Ubuntu (Linux userspace on Windows host)  
* GCC version: Ubuntu 20.04.6  
* Optimizer capability verified using:  
  gcc \-Q \-O2 \--help=optimizers  
* Automation script: run\_optimization\_experiment.sh  
* Stack handling: ulimit \-s unlimited

Optimization flags explored:

* \-O0  
* \-O1  
* \-O2  
* \-O3  
* \-Os

**3\. Methodology**

The report consists of two phases.

**Phase A – Original 11 Programs provided in ppt**

For each program:

1. Compile with \-O0, \-O1, \-O2, \-O3, \-Os

2. Generate assembly (.s) for each level

3. Run each binary 3 times using /usr/bin/time \-p

4. Collect binary sizes using size

5. Compare assembly using diff

6. Count instruction, branch, mul, shift indicators

**Phase B – Additional 8 Team Programs**

For each additional program:

* Compile all optimization levels

* Generate assembly and diff reports

* Perform high-resolution timing:

  * 3 batches

  * 400 runs per batch

  * Average milliseconds per run

      
* Aggregate results into:

  * consolidated\_time\_results.csv

  * consolidated\_size\_results.csv

  * Asm\_stats.csv

**4\. Optimization Level Effect Summary**

| Level | Behavior | Speed | Code Size | Aggressiveness |
| ----- | ----- | :---- | :---- | ----- |
| O0 | Debug-focused | Lowest | Largest | Minimal |
| O1 | Conservative optimization | Moderate | Reduced | Low |
| O2 | Production default | High | Balanced | Moderate |
| O3 | Aggressive speed focus | Highest (often) | May increase | High |
| Os | Size-focused | Competitive | Smallest | Size-biased |

**5\. Overall Performance Summary (Original 11 Programs)**

Average Execution Time (seconds):

* O0: 0.004872

* O1: 0.002821

* O2: 0.002308

* O3: 0.004103

* Os: 0.003077

Fastest overall: **O2**

Average size reduction (Os vs O0): **5.38%**

**6\. Added 8-Program High-Resolution Timing**

Average Runtime (ms per run):

* O0: 7.144546

* O1: 7.395556

* O2: 7.056796

* O3: 6.969034

* Os: 6.937398

Average Binary Size (dec):

* O0: 2351.67

* O1: 2315.00

* O2: 2323.00

* O3: 2304.50

* Os: 2315.00

Interpretation:

* O2 remains a strong default.

* O3 and Os are slightly better for short compute-heavy binaries.

* Startup overhead affects small programs.

**7\. Appendix – Full Source Codes and Outputs**  
**Program 01 – Constant Folding**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int a \= 10 \* 20;  
    printf("%d\\n", a);  
    return 0;  
}

**Output (O0 and O3)**  
200  
**Program 02 – Dead Code Elimination**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int x \= 10, y \= 20, z;  
    z \= x \+ y;  
    return 0;  
}

**Output**

(no stdout output)

**Program 03 – Common Subexpression Elimination**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int x \= 5, y \= 10;  
    int z \= (x \* y) \+ (x \* y);  
    printf("%d\\n", z);  
    return 0;  
}

**Output (O0 and O3)**  
100

**Program 04 – Strength Reduction**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int x \= 5, y;  
    y \= x \* 8;  
    printf("%d\\n", y);  
    return 0;  
}

**Output (O0 and O3)**  
40

**Program 05 – Frequency Reduction / Loop Invariant**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int i, sum \= 0, n \= 10;  
    for (i \= 0; i \< n; i++) {  
        sum \+= i \* n;  
    }  
    printf("%d\\n", sum);  
    return 0;  
}

**Output (O0 and O3)**  
450

**Program 06 – Loop Unrolling**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int a\[8\], i;  
    for (i \= 0; i \< 8; i++) {  
        a\[i\] \= i;  
    }  
    return 0;  
}

**Output**

(no stdout output)

**Program 07 – Loop Jamming / Fusion**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int a\[100\], b\[100\], i;

    for (i \= 0; i \< 100; i++) {  
        a\[i\] \= i;  
    }

    for (i \= 0; i \< 100; i++) {  
        b\[i\] \= a\[i\] \* 2;  
    }

    return 0;  
}

**Output**

(no stdout output)

**Program 08 – Unnecessary Computation (Large)**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int n \= 1000000;  
    int sum \= 0;  
    for (int i \= 0; i \< n; i++) {  
        sum \+= (i \* 2\) \+ (i \* 2);  
    }  
    printf("Sum \= %d\\n", sum);  
    return 0;  
}

**Output (O0 and O3)**  
Sum \= \-1456759936

**Program 09 – Frequency Reduction Constant in Loop (Large)**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int n \= 1000000;  
    double sum \= 0.0;  
    for (int i \= 1; i \<= n; i++) {  
        sum \+= i \* 3.14159;  
    }  
    printf("Sum \= %f\\n", sum);  
    return 0;  
}

**Output (O0 and O3)**  
Sum \= 1570796570794.999512

**Program 10 – Loop Unrolling Large Array**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int n \= 1000000;  
    int sum \= 0;  
    int arr\[1000000\];

    for (int i \= 0; i \< n; i++) {  
        arr\[i\] \= i;  
    }

    for (int i \= 0; i \< n; i++) {  
        sum \+= arr\[i\];  
    }

    printf("Sum \= %d\\n", sum);  
    return 0;  
}

**Output (O0 and O3)**  
Sum \= 1783293664

**Program 11 – Loop Fusion Large**

Source Code  
\#include \<stdio.h\>

int main(void) {  
    int n \= 1000000;  
    int a\[n\], b\[n\], c\[n\], d\[n\];

    for (int i \= 0; i \< n; i++) {  
        a\[i\] \= i;  
        b\[i\] \= 2 \* i;  
    }

    for (int i \= 0; i \< n; i++) {  
        c\[i\] \= a\[i\] \+ b\[i\];  
        d\[i\] \= a\[i\] \- b\[i\];  
    }

    printf("c\[100\] \= %d, d\[100\] \= %d\\n", c\[100\], d\[100\]);  
    return 0;  
}

**Output (O0 and O3)**  
c\[100\] \= 300, d\[100\] \= \-100

**9\. Additional 8 Team Programs (Original Versions):**  
**01\_01\_branch\_deadcode**

**1\. The original program:**

\#include \<stdio.h\>

int main(void) {

    int a \= 10 \* 20;

    int x \= 5;

    int y \= 7;

    int p \= (x \+ y) \* 4 \+ (x \+ y) \* 4;

    int q \= x \* 8;

    int sum \= 0;

    for (int i \= 0; i \< 120; i++) {

        sum \+= i \* 3;

    }

    if (1) {

        sum \+= q;

    } else {

        sum \-= q;

    }

    int dead \= p \* 0;

    sum \= sum \+ 0;

    sum \= sum \* 1;

    printf("%d\\n", a \+ p \+ sum \+ dead);

    return 0;

}

**Output:** 21756

**2\. The assembly code of the optimized program (with \- O0 option):**

main:

.LFB0:

    endbr64

    push	rbp

    mov	rbp, rsp

    sub	rsp, 32

    mov	DWORD PTR \-24\[rbp\], 200

    mov	DWORD PTR \-20\[rbp\], 5

    mov	DWORD PTR \-16\[rbp\], 7

    mov	edx, DWORD PTR \-20\[rbp\]

    mov	eax, DWORD PTR \-16\[rbp\]

    add	eax, edx

    sal	eax, 3

    mov	DWORD PTR \-12\[rbp\], eax

    mov	eax, DWORD PTR \-20\[rbp\]

    sal	eax, 3

    mov	DWORD PTR \-8\[rbp\], eax

    mov	DWORD PTR \-32\[rbp\], 0

    mov	DWORD PTR \-28\[rbp\], 0

    jmp	.L2

.L3:

    mov	edx, DWORD PTR \-28\[rbp\]

    mov	eax, edx

    add	eax, eax

    add	eax, edx

**3\. The assembly code of the optimized program (with \- O1 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	eax, 120

.L2:

    sub	eax, 1

    jne	.L2

    mov	edx, 21756

    lea	rsi, .LC0\[rip\]

    mov	edi, 1

    mov	eax, 0

    call	\_\_printf\_chk@PLT

    mov	eax, 0

    add	rsp, 8

    ret

**4\. The assembly code of the optimized program (with \- O2 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	edx, 21756

    mov	edi, 1

    xor	eax, eax

    lea	rsi, .LC0\[rip\]

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**5\. The assembly code of the optimized program (with \- O3 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	edx, 21756

    mov	edi, 1

    xor	eax, eax

    lea	rsi, .LC0\[rip\]

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**6\. The assembly code of the optimized program (with \- Os option):**

main:

.LFB13:

    endbr64

    push	rax

    mov	edx, 21756

    lea	rsi, .LC0\[rip\]

    xor	eax, eax

    mov	edi, 1

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    pop	rdx

    ret

**02\_02\_cse\_constantprop**

**1\. The original program:**

\#include \<stdio.h\>

int main(void) {

    int n \= 200;

    int a\[200\];

    int b\[200\];

    int c\[200\];

    long long sum \= 0;

    int k \= 12 \* 5;

    for (int i \= 0; i \< n; i++) {

        a\[i\] \= i \+ 1;

    }

    for (int i \= 0; i \< n; i++) {

        b\[i\] \= a\[i\] \* 2;

    }

    for (int i \= 0; i \< n; i++) {

        int t \= b\[i\] \+ k;

        c\[i\] \= t \+ t;

        sum \+= c\[i\];

    }

    if (0) {

        sum \+= 9999;

    }

    int unused \= (k \* 0);

    printf("%lld\\n", sum \+ unused);

    return 0;

}

**Output:** 104400

**2\. The assembly code of the optimized program (with \- O0 option):**

main:

.LFB0:

    endbr64

    push	rbp

    mov	rbp, rsp

    sub	rsp, 2464

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR \-8\[rbp\], rax

    xor	eax, eax

    mov	DWORD PTR \-2440\[rbp\], 200

    mov	QWORD PTR \-2424\[rbp\], 0

    mov	DWORD PTR \-2436\[rbp\], 60

    mov	DWORD PTR \-2452\[rbp\], 0

    jmp	.L2

.L3:

    mov	eax, DWORD PTR \-2452\[rbp\]

    lea	edx, 1\[rax\]

    mov	eax, DWORD PTR \-2452\[rbp\]

    cdqe

    mov	DWORD PTR \-2416\[rbp+rax\*4\], edx

    add	DWORD PTR \-2452\[rbp\], 1

.L2:

    mov	eax, DWORD PTR \-2452\[rbp\]

    cmp	eax, DWORD PTR \-2440\[rbp\]

    jl	.L3

    mov	DWORD PTR \-2448\[rbp\], 0

**3\. The assembly code of the optimized program (with \- O1 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 1624

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 1608\[rsp\], rax

    xor	eax, eax

    mov	eax, 1

.L2:

    mov	DWORD PTR \-4\[rsp+rax\*4\], eax

    add	rax, 1

    cmp	rax, 201

    jne	.L2

    mov	eax, 0

.L3:

    mov	edi, DWORD PTR \[rsp+rax\]

    lea	edx, \[rdi+rdi\]

    mov	DWORD PTR 800\[rsp+rax\], edx

    add	rax, 4

    cmp	rax, 800

    jne	.L3

    lea	rax, 800\[rsp\]

    lea	rsi, 1600\[rsp\]

    mov	ecx, 0

.L4:

    mov	edx, DWORD PTR \[rax\]

    lea	edx, 120\[rdx+rdx\]

**4\. The assembly code of the optimized program (with \- O2 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 1624

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 1608\[rsp\], rax

    xor	eax, eax

    mov	rsi, rsp

    mov	eax, 1

.L2:

    mov	DWORD PTR \-4\[rsi+rax\*4\], eax

    add	rax, 1

    cmp	rax, 201

    jne	.L2

    xor	edx, edx

    lea	rax, 800\[rsp\]

.L3:

    mov	edi, DWORD PTR \[rsi+rdx\]

    lea	ecx, \[rdi+rdi\]

    mov	DWORD PTR \[rax+rdx\], ecx

    add	rdx, 4

    cmp	rdx, 800

    jne	.L3

    lea	rcx, 1600\[rsp\]

    xor	r8d, r8d

.L4:

    mov	edx, DWORD PTR \[rax\]

**5\. The assembly code of the optimized program (with \- O3 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 1624

    movdqa	xmm1, XMMWORD PTR .LC0\[rip\]

    movdqa	xmm3, XMMWORD PTR .LC1\[rip\]

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 1608\[rsp\], rax

    xor	eax, eax

    mov	rcx, rsp

    movdqa	xmm2, XMMWORD PTR .LC2\[rip\]

    lea	rax, 800\[rsp\]

    mov	rdx, rcx

.L2:

    movdqa	xmm0, xmm1

    add	rdx, 16

    paddd	xmm1, xmm3

    paddd	xmm0, xmm2

    movaps	XMMWORD PTR \-16\[rdx\], xmm0

    cmp	rax, rdx

    jne	.L2

    xor	edx, edx

.L3:

    movdqa	xmm0, XMMWORD PTR \[rcx+rdx\]

    pslld	xmm0, 1

    movaps	XMMWORD PTR \[rax+rdx\], xmm0

**6\. The assembly code of the optimized program (with \- Os option):**

main:

.LFB13:

    endbr64

    sub	rsp, 1624

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 1608\[rsp\], rax

    xor	eax, eax

    lea	rcx, 8\[rsp\]

    mov	eax, 1

.L2:

    mov	DWORD PTR \-4\[rcx+rax\*4\], eax

    inc	rax

    cmp	rax, 201

    jne	.L2

    xor	eax, eax

    lea	rsi, 808\[rsp\]

.L3:

    mov	edi, DWORD PTR \[rcx+rax\]

    add	rax, 4

    lea	edx, \[rdi+rdi\]

    mov	DWORD PTR \-4\[rax+rsi\], edx

    cmp	rax, 800

    jne	.L3

    xor	eax, eax

    xor	edx, edx

.L4:

    mov	ecx, DWORD PTR \[rsi+rax\*4\]

**03\_03\_strength\_induction**

**1\. The original program:**

\#include \<stdio.h\>

int main(void) {

    long long total \= 0;

    int n \= 1000;

    int c \= 6 \* 7;

    for (int i \= 0; i \< n; i++) {

        total \+= i \* 8;

        total \+= i \* 4;

        total \+= (i \+ c) \- (i \+ c);

    }

    if (1) {

        total \+= c;

    } else {

        total \-= c;

    }

    total \= total \* 1;

    printf("%lld\\n", total);

    return 0;

}

**Output:** 5994042

**2\. The assembly code of the optimized program (with \- O0 option):**

main:

.LFB0:

    endbr64

    push	rbp

    mov	rbp, rsp

    sub	rsp, 32

    mov	QWORD PTR \-8\[rbp\], 0

    mov	DWORD PTR \-16\[rbp\], 1000

    mov	DWORD PTR \-12\[rbp\], 42

    mov	DWORD PTR \-20\[rbp\], 0

    jmp	.L2

.L3:

    mov	eax, DWORD PTR \-20\[rbp\]

    sal	eax, 3

    cdqe

    add	QWORD PTR \-8\[rbp\], rax

    mov	eax, DWORD PTR \-20\[rbp\]

    sal	eax, 2

    cdqe

    add	QWORD PTR \-8\[rbp\], rax

    add	DWORD PTR \-20\[rbp\], 1

.L2:

    mov	eax, DWORD PTR \-20\[rbp\]

    cmp	eax, DWORD PTR \-16\[rbp\]

    jl	.L3

    mov	eax, DWORD PTR \-12\[rbp\]

**3\. The assembly code of the optimized program (with \- O1 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	eax, 1000

.L2:

    sub	eax, 1

    jne	.L2

    mov	edx, 5994042

    lea	rsi, .LC0\[rip\]

    mov	edi, 1

    mov	eax, 0

    call	\_\_printf\_chk@PLT

    mov	eax, 0

    add	rsp, 8

    ret

**4\. The assembly code of the optimized program (with \- O2 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	edx, 5994042

    mov	edi, 1

    xor	eax, eax

    lea	rsi, .LC0\[rip\]

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**5\. The assembly code of the optimized program (with \- O3 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	edx, 5994042

    mov	edi, 1

    xor	eax, eax

    lea	rsi, .LC0\[rip\]

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**6\. The assembly code of the optimized program (with \- Os option):**

main:

.LFB13:

    endbr64

    push	rax

    mov	edx, 5994042

    lea	rsi, .LC0\[rip\]

    xor	eax, eax

    mov	edi, 1

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    pop	rdx

    ret

**04\_04\_loop\_invariant\_freq**

**1\. The original program:**

\#include \<stdio.h\>

int main(void) {

    int n \= 100000;

    double principal \= 1000.0;

    double rate \= 1.07;

    double bonus \= 0.35;

    double sum \= 0.0;

    int k \= 40 \* 2;

    for (int i \= 0; i \< n; i++) {

        sum \+= principal \* rate \+ bonus;

        sum \+= (k \- k);

    }

    if (0) {

        sum \+= 100.0;

    }

    printf("%.2f\\n", sum);

    return 0;

}

**Output:** 107035000.00

**2\. The assembly code of the optimized program (with \- O0 option):**

main:

.LFB0:

    endbr64

    push	rbp

    mov	rbp, rsp

    sub	rsp, 48

    mov	DWORD PTR \-40\[rbp\], 100000

    movsd	xmm0, QWORD PTR .LC0\[rip\]

    movsd	QWORD PTR \-24\[rbp\], xmm0

    movsd	xmm0, QWORD PTR .LC1\[rip\]

    movsd	QWORD PTR \-16\[rbp\], xmm0

    movsd	xmm0, QWORD PTR .LC2\[rip\]

    movsd	QWORD PTR \-8\[rbp\], xmm0

    pxor	xmm0, xmm0

    movsd	QWORD PTR \-32\[rbp\], xmm0

    mov	DWORD PTR \-36\[rbp\], 80

    mov	DWORD PTR \-44\[rbp\], 0

    jmp	.L2

.L3:

    movsd	xmm0, QWORD PTR \-24\[rbp\]

    mulsd	xmm0, QWORD PTR \-16\[rbp\]

    addsd	xmm0, QWORD PTR \-8\[rbp\]

    movsd	xmm1, QWORD PTR \-32\[rbp\]

    addsd	xmm0, xmm1

    movsd	QWORD PTR \-32\[rbp\], xmm0

**3\. The assembly code of the optimized program (with \- O1 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	eax, 100000

    pxor	xmm0, xmm0

    movsd	xmm2, QWORD PTR .LC1\[rip\]

    movapd	xmm1, xmm0

.L2:

    addsd	xmm0, xmm2

    addsd	xmm0, xmm1

    sub	eax, 1

    jne	.L2

    lea	rsi, .LC2\[rip\]

    mov	edi, 1

    mov	eax, 1

    call	\_\_printf\_chk@PLT

    mov	eax, 0

    add	rsp, 8

    ret

**4\. The assembly code of the optimized program (with \- O2 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    pxor	xmm1, xmm1

    mov	eax, 100000

    movsd	xmm2, QWORD PTR .LC1\[rip\]

    movapd	xmm0, xmm1

.L2:

    addsd	xmm0, xmm2

    addsd	xmm0, xmm1

    sub	eax, 1

    jne	.L2

    lea	rsi, .LC2\[rip\]

    mov	edi, 1

    mov	eax, 1

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**5\. The assembly code of the optimized program (with \- O3 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    pxor	xmm1, xmm1

    mov	eax, 100000

    movsd	xmm2, QWORD PTR .LC1\[rip\]

    movapd	xmm0, xmm1

.L2:

    addsd	xmm0, xmm2

    addsd	xmm0, xmm1

    sub	eax, 1

    jne	.L2

    lea	rsi, .LC2\[rip\]

    mov	edi, 1

    mov	eax, 1

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**6\. The assembly code of the optimized program (with \- Os option):**

main:

.LFB13:

    endbr64

    xorps	xmm0, xmm0

    push	rcx

    movsd	xmm2, QWORD PTR .LC1\[rip\]

    mov	eax, 100000

    movapd	xmm1, xmm0

.L2:

    addsd	xmm0, xmm2

    addsd	xmm0, xmm1

    dec	eax

    jne	.L2

    lea	rsi, .LC2\[rip\]

    mov	edi, 1

    mov	al, 1

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    pop	rdx

    ret

**05\_05\_loop\_fusion\_jamming**

**1\. The original program:**

\#include \<stdio.h\>

int main(void) {

    int n \= 800;

    int a\[800\];

    int b\[800\];

    int c\[800\];

    long long sum \= 0;

    int m \= 3 \* 9;

    for (int i \= 0; i \< n; i++) {

        a\[i\] \= i;

    }

    for (int i \= 0; i \< n; i++) {

        b\[i\] \= a\[i\] \* 3;

    }

    for (int i \= 0; i \< n; i++) {

        c\[i\] \= b\[i\] \+ m;

        sum \+= c\[i\];

    }

    if (1) {

        sum \+= 0;

    }

    printf("%lld\\n", sum);

    return 0;

}

**Output:** 980400

**2\. The assembly code of the optimized program (with \- O0 option):**

main:

.LFB0:

    endbr64

    push	rbp

    mov	rbp, rsp

    sub	rsp, 4096

    or	QWORD PTR \[rsp\], 0

    sub	rsp, 4096

    or	QWORD PTR \[rsp\], 0

    sub	rsp, 1456

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR \-8\[rbp\], rax

    xor	eax, eax

    mov	DWORD PTR \-9632\[rbp\], 800

    mov	QWORD PTR \-9624\[rbp\], 0

    mov	DWORD PTR \-9628\[rbp\], 27

    mov	DWORD PTR \-9644\[rbp\], 0

    jmp	.L2

.L3:

    mov	eax, DWORD PTR \-9644\[rbp\]

    cdqe

    mov	edx, DWORD PTR \-9644\[rbp\]

    mov	DWORD PTR \-9616\[rbp+rax\*4\], edx

    add	DWORD PTR \-9644\[rbp\], 1

.L2:

    mov	eax, DWORD PTR \-9644\[rbp\]

**3\. The assembly code of the optimized program (with \- O1 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 4096

    or	QWORD PTR \[rsp\], 0

    sub	rsp, 2328

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 6408\[rsp\], rax

    xor	eax, eax

.L2:

    mov	DWORD PTR \[rsp+rax\*4\], eax

    add	rax, 1

    cmp	rax, 800

    jne	.L2

    mov	eax, 0

.L3:

    mov	edx, DWORD PTR \[rsp+rax\]

    lea	edx, \[rdx+rdx\*2\]

    mov	DWORD PTR 3200\[rsp+rax\], edx

    add	rax, 4

    cmp	rax, 3200

    jne	.L3

    lea	rdx, 3200\[rsp\]

    lea	rsi, 6400\[rsp\]

    mov	ecx, 0

.L4:

    mov	eax, DWORD PTR \[rdx\]

**4\. The assembly code of the optimized program (with \- O2 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 4096

    or	QWORD PTR \[rsp\], 0

    sub	rsp, 2328

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 6408\[rsp\], rax

    xor	eax, eax

    mov	rsi, rsp

.L2:

    mov	DWORD PTR \[rsi+rax\*4\], eax

    add	rax, 1

    cmp	rax, 800

    jne	.L2

    xor	eax, eax

    lea	rdx, 3200\[rsp\]

.L3:

    mov	ecx, DWORD PTR \[rsi+rax\]

    lea	ecx, \[rcx+rcx\*2\]

    mov	DWORD PTR \[rdx+rax\], ecx

    add	rax, 4

    cmp	rax, 3200

    jne	.L3

    lea	rcx, 6400\[rsp\]

    xor	r8d, r8d

**5\. The assembly code of the optimized program (with \- O3 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 4096

    or	QWORD PTR \[rsp\], 0

    sub	rsp, 2328

    movdqa	xmm0, XMMWORD PTR .LC0\[rip\]

    movdqa	xmm2, XMMWORD PTR .LC1\[rip\]

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 6408\[rsp\], rax

    xor	eax, eax

    mov	rcx, rsp

    lea	rax, 3200\[rsp\]

    mov	rdx, rcx

.L2:

    movdqa	xmm1, xmm0

    add	rdx, 16

    paddd	xmm0, xmm2

    movaps	XMMWORD PTR \-16\[rdx\], xmm1

    cmp	rax, rdx

    jne	.L2

    xor	edx, edx

.L3:

    movdqa	xmm0, XMMWORD PTR \[rcx+rdx\]

    pslld	xmm0, 1

    paddd	xmm0, XMMWORD PTR \[rcx+rdx\]

**6\. The assembly code of the optimized program (with \- Os option):**

main:

.LFB13:

    endbr64

    sub	rsp, 4096

    or	QWORD PTR \[rsp\], 0

    sub	rsp, 2328

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 6408\[rsp\], rax

    xor	eax, eax

    lea	rdx, 8\[rsp\]

.L2:

    mov	DWORD PTR \[rdx+rax\*4\], eax

    inc	rax

    cmp	rax, 800

    jne	.L2

    xor	eax, eax

    lea	rcx, 3208\[rsp\]

.L3:

    imul	esi, DWORD PTR \[rdx+rax\], 3

    add	rax, 4

    mov	DWORD PTR \-4\[rax+rcx\], esi

    cmp	rax, 3200

    jne	.L3

    xor	edx, edx

    xor	r8d, r8d

.L4:

    mov	eax, DWORD PTR \[rcx+rdx\*4\]

**06\_06\_inlining\_unrolling**

**1\. The original program:**

\#include \<stdio.h\>

int square(int x) {

    return x \* x;

}

int main(void) {

    int arr\[16\];

    long long s \= 0;

    int n \= 16;

    int c \= 20 \* 5;

    for (int i \= 0; i \< n; i++) {

        arr\[i\] \= i \+ 1;

    }

    for (int i \= 0; i \< n; i++) {

        s \+= square(arr\[i\]);

        s \+= (arr\[i\] \* 2\) \- (arr\[i\] \* 2);

    }

    if (0) {

        s \+= c;

    }

    s \= s \* 1;

    printf("%lld\\n", s);

    return 0;

}

**Output:** 1496

**2\. The assembly code of the optimized program (with \- O0 option):**

main:

.LFB1:

    endbr64

    push	rbp

    mov	rbp, rsp

    sub	rsp, 112

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR \-8\[rbp\], rax

    xor	eax, eax

    mov	QWORD PTR \-88\[rbp\], 0

    mov	DWORD PTR \-96\[rbp\], 16

    mov	DWORD PTR \-92\[rbp\], 100

    mov	DWORD PTR \-104\[rbp\], 0

    jmp	.L4

.L5:

    mov	eax, DWORD PTR \-104\[rbp\]

    lea	edx, 1\[rax\]

    mov	eax, DWORD PTR \-104\[rbp\]

    cdqe

    mov	DWORD PTR \-80\[rbp+rax\*4\], edx

    add	DWORD PTR \-104\[rbp\], 1

.L4:

    mov	eax, DWORD PTR \-104\[rbp\]

    cmp	eax, DWORD PTR \-96\[rbp\]

    jl	.L5

    mov	DWORD PTR \-100\[rbp\], 0

**3\. The assembly code of the optimized program (with \- O1 option):**

main:

.LFB24:

    endbr64

    sub	rsp, 88

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 72\[rsp\], rax

    xor	eax, eax

    mov	eax, 1

.L3:

    mov	DWORD PTR \-4\[rsp+rax\*4\], eax

    add	rax, 1

    cmp	rax, 17

    jne	.L3

    mov	rdx, rsp

    lea	rsi, 64\[rsp\]

    mov	ecx, 0

.L4:

    mov	eax, DWORD PTR \[rdx\]

    imul	eax, eax

    cdqe

    add	rcx, rax

    add	rdx, 4

    cmp	rdx, rsi

    jne	.L4

    mov	rdx, rcx

    lea	rsi, .LC0\[rip\]

**4\. The assembly code of the optimized program (with \- O2 option):**

main:

.LFB24:

    endbr64

    sub	rsp, 88

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 72\[rsp\], rax

    xor	eax, eax

    mov	rdx, rsp

    mov	eax, 1

.L4:

    mov	DWORD PTR \-4\[rdx+rax\*4\], eax

    add	rax, 1

    cmp	rax, 17

    jne	.L4

    lea	rcx, 64\[rsp\]

    xor	r8d, r8d

.L5:

    mov	eax, DWORD PTR \[rdx\]

    add	rdx, 4

    imul	eax, eax

    cdqe

    add	r8, rax

    cmp	rdx, rcx

    jne	.L5

    xor	eax, eax

    mov	rdx, r8

**5\. The assembly code of the optimized program (with \- O3 option):**

main:

.LFB24:

    endbr64

    sub	rsp, 8

    mov	edx, 1496

    mov	edi, 1

    xor	eax, eax

    lea	rsi, .LC0\[rip\]

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**6\. The assembly code of the optimized program (with \- Os option):**

main:

.LFB14:

    endbr64

    sub	rsp, 88

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR 72\[rsp\], rax

    xor	eax, eax

    lea	rcx, 8\[rsp\]

    mov	eax, 1

.L3:

    mov	DWORD PTR \-4\[rcx+rax\*4\], eax

    inc	rax

    cmp	rax, 17

    jne	.L3

    xor	edx, edx

    xor	r8d, r8d

.L4:

    mov	eax, DWORD PTR \[rcx+rdx\*4\]

    inc	rdx

    imul	eax, eax

    cdqe

    add	r8, rax

    cmp	rdx, 16

    jne	.L4

    xor	eax, eax

    mov	rdx, r8

**07\_combined\_program\_1**

**1\. The original program:**

\#include \<stdio.h\>

int square(int x) {

    return x \* x;

}

int main(void) {

    int a \= 10 \* 20;

    int unused \= a \+ 100;

    int x \= 5;

    int y \= 10;

    int z \= (x \* y) \+ (x \* y);

    int p \= x \* 8;

    int sum \= 0;

    int n \= 100;

    for (int i \= 0; i \< n; i++) {

        sum \+= i \* n;

    }

    for (int i \= 0; i \< 8; i++) {

        sum \+= i;

    }

    if (10 \> 20\) {

        sum \= 0;

    }

    printf("%d\\n", sum \+ square(z));

    (void)unused;

    (void)p;

    return 0;

}

**Output (Run 1\)**

O0: 505028

O3: 505028

**2\. The assembly code of the optimized program (with \- O0 option):**

main:

.LFB1:

    endbr64

    push	rbp

    mov	rbp, rsp

    sub	rsp, 48

    mov	DWORD PTR \-28\[rbp\], 200

    mov	eax, DWORD PTR \-28\[rbp\]

    add	eax, 100

    mov	DWORD PTR \-24\[rbp\], eax

    mov	DWORD PTR \-20\[rbp\], 5

    mov	DWORD PTR \-16\[rbp\], 10

    mov	eax, DWORD PTR \-20\[rbp\]

    imul	eax, DWORD PTR \-16\[rbp\]

    add	eax, eax

    mov	DWORD PTR \-12\[rbp\], eax

    mov	eax, DWORD PTR \-20\[rbp\]

    sal	eax, 3

    mov	DWORD PTR \-8\[rbp\], eax

    mov	DWORD PTR \-40\[rbp\], 0

    mov	DWORD PTR \-4\[rbp\], 100

    mov	DWORD PTR \-36\[rbp\], 0

    jmp	.L4

.L5:

    mov	eax, DWORD PTR \-36\[rbp\]

**3\. The assembly code of the optimized program (with \- O1 option):**

main:

.LFB24:

    endbr64

    sub	rsp, 8

    mov	eax, 100

.L3:

    sub	eax, 1

    jne	.L3

    mov	edx, 505028

    lea	rsi, .LC0\[rip\]

    mov	edi, 1

    mov	eax, 0

    call	\_\_printf\_chk@PLT

    mov	eax, 0

    add	rsp, 8

    ret

**4\. The assembly code of the optimized program (with \- O2 option):**

main:

.LFB24:

    endbr64

    sub	rsp, 8

    mov	edx, 505028

    mov	edi, 1

    xor	eax, eax

    lea	rsi, .LC0\[rip\]

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**5\. The assembly code of the optimized program (with \- O3 option):**

main:

.LFB24:

    endbr64

    sub	rsp, 8

    mov	edx, 505028

    mov	edi, 1

    xor	eax, eax

    lea	rsi, .LC0\[rip\]

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**6\. The assembly code of the optimized program (with \- Os option):**

main:

.LFB14:

    endbr64

    push	rax

    mov	edx, 505028

    lea	rsi, .LC0\[rip\]

    xor	eax, eax

    mov	edi, 1

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    pop	rdx

    ret

**08\_combined\_program\_2**

**1\. The original program:**

\#include \<stdio.h\>

int main(void) {

    int n \= 1000;

    int a\[1000\], b\[1000\], c\[1000\];

    int sum \= 0;

    for (int i \= 0; i \< n; i++) {

        a\[i\] \= i \* 2;

    }

    for (int i \= 0; i \< n; i++) {

        b\[i\] \= a\[i\] \+ 5;

    }

    for (int i \= 0; i \< n; i++) {

        int t \= i \* 4;

        sum \+= t \+ (i \* 4);

    }

    int useless \= sum \* 0;

    int k \= 50 \* 2;

    if (k \< 10\) {

        sum \= 1;

    }

    printf("%d\\n", sum);

    (void)c;

    (void)useless;

    return 0;

}

**Output (Run 1\)**

O0: 3996000

O3: 3996000

**2\. The assembly code of the optimized program (with \- O0 option):**

main:

.LFB0:

    endbr64

    push	rbp

    mov	rbp, rsp

    sub	rsp, 4096

    or	QWORD PTR \[rsp\], 0

    sub	rsp, 3952

    mov	rax, QWORD PTR fs:40

    mov	QWORD PTR \-8\[rbp\], rax

    xor	eax, eax

    mov	DWORD PTR \-8032\[rbp\], 1000

    mov	DWORD PTR \-8048\[rbp\], 0

    mov	DWORD PTR \-8044\[rbp\], 0

    jmp	.L2

.L3:

    mov	eax, DWORD PTR \-8044\[rbp\]

    lea	edx, \[rax+rax\]

    mov	eax, DWORD PTR \-8044\[rbp\]

    cdqe

    mov	DWORD PTR \-8016\[rbp+rax\*4\], edx

    add	DWORD PTR \-8044\[rbp\], 1

.L2:

    mov	eax, DWORD PTR \-8044\[rbp\]

    cmp	eax, DWORD PTR \-8032\[rbp\]

    jl	.L3

**3\. The assembly code of the optimized program (with \- O1 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	eax, 1000

.L2:

    sub	eax, 1

    jne	.L2

    mov	eax, 1000

.L3:

    sub	eax, 1

    jne	.L3

    mov	eax, 1000

.L4:

    sub	eax, 1

    jne	.L4

    mov	edx, 3996000

    lea	rsi, .LC0\[rip\]

    mov	edi, 1

    mov	eax, 0

    call	\_\_printf\_chk@PLT

    mov	eax, 0

    add	rsp, 8

    ret

**4\. The assembly code of the optimized program (with \- O2 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	edx, 3996000

    mov	edi, 1

    xor	eax, eax

    lea	rsi, .LC0\[rip\]

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**5\. The assembly code of the optimized program (with \- O3 option):**

main:

.LFB23:

    endbr64

    sub	rsp, 8

    mov	edx, 3996000

    mov	edi, 1

    xor	eax, eax

    lea	rsi, .LC0\[rip\]

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    add	rsp, 8

    ret

**6\. The assembly code of the optimized program (with \- Os option):**

main:

.LFB13:

    endbr64

    push	rax

    mov	edx, 3996000

    lea	rsi, .LC0\[rip\]

    xor	eax, eax

    mov	edi, 1

    call	\_\_printf\_chk@PLT

    xor	eax, eax

    pop	rdx

    ret

**10\. High-Resolution Execution Time (Additional 8 Programs)**

Measured using:

* 3 batches

* 400 executions per batch

* Reported as average milliseconds per run

| Program | O0 | O1 | O2 | O3 | Os |
| ----- | ----- | ----- | ----- | ----- | ----- |
| 01\_branch\_deadcode | 8.334715 | 7.937714 | 8.590574 | 8.884098 | 8.513701 |
| 02\_cse\_constantprop | 7.532601 | 7.343577 | 7.487759 | 8.789035 | 8.474430 |
| 03\_strength\_induction | 8.122372 | 8.303642 | 8.424683 | 8.051594 | 8.496478 |
| 04\_loop\_invariant\_freq | 8.855718 | 7.665630 | 7.689395 | 7.601018 | 7.612910 |
| 05\_loop\_fusion\_jamming | 7.377363 | 6.383279 | 6.468513 | 7.304007 | 6.292078 |
| 06\_inlining\_unrolling | 6.466745 | 6.388372 | 6.354640 | 6.822710 | 7.655191 |
| 07\_combined\_program\_1 | 4.593434 | 4.077547 | 5.072366 | 4.717936 | 4.727123 |
| 08\_combined\_program\_2 | 5.493608 | 4.977741 | 4.689418 | 4.528788 | 5.504044 |

Updated per-level averages (ms per run):

* O0 \= 7.097070  
* O1 \= 6.634688  
* O2 \= 6.847169  
* O3 \= 7.087398  
* Os \= 7.159494


**11\. Binary Size Results (Additional 8 Programs)**

Binary size reported using size (dec column).

| Program | O0 | O1 | O2 | O3 | Os | Smallest |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| 01\_branch\_deadcode | 2279 | 2209 | 2209 | 2209 | 2209 | O1/O2/O3/Os |
| 02\_cse\_constantprop | 2638 | 2496 | 2512 | 2662 | 2480 | Os |
| 03\_strength\_induction | 2249 | 2211 | 2211 | 2211 | 2211 | O1/O2/O3/Os |
| 04\_loop\_invariant\_freq | 2343 | 2257 | 2257 | 2257 | 2241 | Os |
| 05\_loop\_fusion\_jamming | 2622 | 2496 | 2496 | 2670 | 2480 | Os |
| 06\_inlining\_unrolling | 2502 | 2472 | 2488 | 2259 | 2472 | O3 |
| 07\_combined\_program\_1 | 2367 | 2257 | 2257 | 2257 | 2257 | O1/O2/O3/Os |
| 08\_combined\_program\_2 | 2620 | 2241 | 2209 | 2209 | 2209 | O2/O3/Os |

Updated per-level average dec size:

* O0 \= 2452.500000  
* O1 \= 2329.875000  
* O2 \= 2329.875000  
* O3 \= 2341.750000  
* Os \= 2319.875000

**12\. Assembly-Level Observations by Optimization Level**

Instruction and branch metrics were collected from generated .s files for each optimization level.

**01\_branch\_deadcode**

Instruction count:

* O0 → 43

* O1 → 13

* O2 → 10

* O3 → 10

* Os → 10

Branch count:

* O0 → 2

* O1 → 1

* O2 → 0

* O3 → 0

* Os → 0

Observations:

* Constant-condition branch eliminated at optimized levels.

* Arithmetic identities removed.

* Control flow simplified to straight-line code.

**02\_cse\_constantprop**

Instruction count:

* O0 → 72

* O1 → 39

* O2 → 40

* O3 → 57

* Os → 39

Branch count:

* O0 → 7

* O1 → 4

* O2 → 4

* O3 → 4

* Os → 4

Observations:

* Common subexpressions are folded.

* Dead branch removed.

* O3 expands due to vectorization/unrolling.

* Os yields the smallest binary (2480).

**03\_strength\_induction**

Instruction count:

* O0 → 32

* O1 → 13

* O2 → 10

* O3 → 10

* Os → 10

Branch count:

* O0 → 2

* O1 → 1

* O2 → 0

* O3 → 0

* Os → 0

Observations:

* Redundant arithmetic removed.

* Induction simplification performed.

* Final code collapses to a constant output path at higher levels.

**04\_loop\_invariant\_freq**

Instruction count:

* O0 → 38

* O1 → 17

* O2 → 17

* O3 → 17

* Os → 17

Branch count:

* O0 → 2

* O1 → 1

* O2 → 1

* O3 → 1

* Os → 1

Observations:

* Loop-invariant expression hoisted.

* Dead (k-k) removed.

* Binary size reduces from 2343 (O0) to 2241 (Os).

**05\_loop\_fusion\_jamming**

Instruction count:

* O0 → 70

* O1 → 40

* O2 → 41

* O3 → 57

* Os → 40

Branch count:

* O0 → 7

* O1 → 4

* O2 → 4

* O3 → 4

* Os → 4

Observations:

* Loop control reduced.

* O3 increases instruction count (vectorization expansion).

* Os smallest binary (2480).

* O3 largest binary (2670).

**06\_inlining\_unrolling**

Instruction count:

* O0 → 54

* O1 → 36

* O2 → 36

* O3 → 14

* Os → 36

Branch count:

* O0 → 5

* O1 → 2

* O2 → 2

* O3 → 0

* Os → 2

Observations:

* Function fully inlined at O3.

* Loop fully eliminated.

* Assembly collapses to direct constant print.

* Binary size minimum at O3 (2259).

**07\_combined\_program\_1**

Instruction count:

* O0 → 55  
* O1 → 17  
* O2 → 14  
* O3 → 14  
* Os → 14

Branch count:

* O0 → 4  
* O1 → 1  
* O2 → 0  
* O3 → 0  
* Os → 0

Observations:

* Common subexpression arithmetic collapses at optimized levels.  
* Unreachable branch path is removed.  
* Dead variables are eliminated from final code path.  
* Loop computation is heavily simplified to near straight-line output logic at O2/O3/Os.

**08\_combined\_program\_2**

Instruction count:

* O0 → 66  
* O1 → 19  
* O2 → 10  
* O3 → 10  
* Os → 10

Branch count:

* O0 → 8  
* O1 → 3  
* O2 → 0  
* O3 → 0  
* Os → 0

Observations:

* Dead branches and dead variables are removed after optimization.  
* Repeated loop arithmetic is folded/simplified.  
* Control flow reduces from branch-heavy O0 to branch-free O2/O3/Os.  
* High levels collapse computation toward direct constant-result output behavior.

**13\. Per-Code Optimization Diagnosis**

**01\_branch\_deadcode**

**Problematic snippet:**

if (1) {

    sum \+= q;

} else {

    sum \-= q;

}

int dead \= p \* 0;

sum \= sum \+ 0;

sum \= sum \* 1;

**Why inefficient:**

* Constant branch.  
* Algebraic identities.  
* Dead variable.  
* Repeated expressions.

**Optimizations involved:**

* Constant folding  
* Dead code elimination  
* Branch elimination  
* Common subexpression elimination  
* Strength reduction

Assembly snippets matching this snippet:

**O0**

cmp	DWORD PTR \-8\[rbp\], 0

je	.L2

add	DWORD PTR \-32\[rbp\], DWORD PTR \-8\[rbp\]

jmp	.L3

.L2:

sub	DWORD PTR \-32\[rbp\], DWORD PTR \-8\[rbp\]

.L3:

mov	DWORD PTR \-4\[rbp\], 0

**O1**

mov	eax, 120

.L2:

sub	eax, 1

jne	.L2

mov	edx, 21756

call	\_\_printf\_chk@PLT

**O2**

mov	edx, 21756

mov	edi, 1

xor	eax, eax

lea	rsi, .LC0\[rip\]

call	\_\_printf\_chk@PLT

**O3**

mov	edx, 21756

mov	edi, 1

xor	eax, eax

lea	rsi, .LC0\[rip\]

call	\_\_printf\_chk@PLT

**Os**

push	rax

mov	edx, 21756

lea	rsi, .LC0\[rip\]

xor	eax, eax

mov	edi, 1

call	\_\_printf\_chk@PLT

**02\_cse\_constantprop**

**Problematic snippet:**

int k \= 12 \* 5;

if (0) {

    sum \+= 9999;

}

int unused \= (k \* 0);

**Why inefficient:**

* Dead branch.  
* Unused variable.  
* Multiple passes over the same index range.

**Optimizations involved:**

* Constant propagation  
* Dead code elimination  
* Loop fusion (manual improvement)  
* Strength reduction

**Assembly snippets matching this snippet:**

**O0**

mov	DWORD PTR \-2436\[rbp\], 60

...

mov	DWORD PTR \-2428\[rbp\], 0

mov	eax, DWORD PTR \-2428\[rbp\]

cdqe

mov	rdx, QWORD PTR \-2424\[rbp\]

add	rdx, rax

**O1**

lea	rax, 800\[rsp\]

lea	rsi, 1600\[rsp\]

mov	ecx, 0

.L4:

mov	edx, DWORD PTR \[rax\]

lea	edx, 120\[rdx+rdx\]

mov	DWORD PTR \[rax\], edx

**O2**

lea	rcx, 1600\[rsp\]

xor	r8d, r8d

.L4:

mov	edx, DWORD PTR \[rax\]

lea	edx, 120\[rdx+rdx\]

add	r8, rdx

add	rax, 4

**O3**

movdqa	xmm0, XMMWORD PTR \[rcx+rdx\]

pslld	xmm0, 1

movdqa	xmm4, xmm0

paddd	xmm4, XMMWORD PTR .LC3\[rip\]

movaps	XMMWORD PTR \[rax+rdx\], xmm4

**Os**

xor	eax, eax

xor	edx, edx

.L4:

mov	ecx, DWORD PTR \[rsi+rax\*4\]

lea	ecx, 120\[rcx+rcx\]

add	edx, ecx

inc	rax

**03\_strength\_induction**

**Problematic snippet:**

total \+= (i \+ c) \- (i \+ c);

if (1) {

   total \+= c;

}

total \= total \* 1;

**Why inefficient:**

* Always-zero arithmetic.  
* Constant branch.  
* Redundant multiplication.

**Optimizations involved:**

* Induction variable simplification  
* Strength reduction  
* Dead code elimination

**Assembly snippets matching this snippet:**

**O0**

mov	eax, DWORD PTR \-20\[rbp\]

sal	eax, 3

cdqe

add	QWORD PTR \-8\[rbp\], rax

mov	eax, DWORD PTR \-20\[rbp\]

sal	eax, 2

cdqe

add	QWORD PTR \-8\[rbp\], rax

**O1**

mov	eax, 1000

.L2:

sub	eax, 1

jne	.L2

mov	edx, 5994042

call	\_\_printf\_chk@PLT

**O2**

mov	edx, 5994042

mov	edi, 1

xor	eax, eax

lea	rsi, .LC0\[rip\]

call	\_\_printf\_chk@PLT

**O3**

mov	edx, 5994042

mov	edi, 1

xor	eax, eax

lea	rsi, .LC0\[rip\]

call	\_\_printf\_chk@PLT

**Os**

push	rax

mov	edx, 5994042

lea	rsi, .LC0\[rip\]

xor	eax, eax

mov	edi, 1

call	\_\_printf\_chk@PLT

**04\_loop\_invariant\_freq**

**Problematic snippet:**

sum \+= principal \* rate \+ bonus;

sum \+= (k \- k);

if (0) {

   sum \+= 100.0;

}

**Why inefficient:**

* Loop invariant expression inside loop.  
* Zero arithmetic.  
* Dead branch.

**Optimizations involved:**

* Loop invariant code motion  
* Frequency reduction  
* Dead code elimination

**Assembly snippets matching this snippet:**

**O0**

movsd	xmm0, QWORD PTR \-24\[rbp\]

mulsd	xmm0, QWORD PTR \-16\[rbp\]

addsd	xmm0, QWORD PTR \-8\[rbp\]

movsd	xmm1, QWORD PTR \-32\[rbp\]

addsd	xmm0, xmm1

movsd	QWORD PTR \-32\[rbp\], xmm0

**O1**

mov	eax, 100000

movsd	xmm2, QWORD PTR .LC1\[rip\]

.L2:

addsd	xmm0, xmm2

addsd	xmm0, xmm1

sub	eax, 1

jne	.L2

**O2**

mov	eax, 100000

movsd	xmm2, QWORD PTR .LC1\[rip\]

.L2:

addsd	xmm0, xmm2

addsd	xmm0, xmm1

sub	eax, 1

jne	.L2

**O3**

mov	eax, 100000

movsd	xmm2, QWORD PTR .LC1\[rip\]

.L2:

addsd	xmm0, xmm2

addsd	xmm0, xmm1

sub	eax, 1

jne	.L2

**Os**

mov	eax, 100000

movsd	xmm2, QWORD PTR .LC1\[rip\]

.L2:

addsd	xmm0, xmm2

addsd	xmm0, xmm1

dec	eax

jne	.L2

**05\_loop\_fusion\_jamming**

**Problematic snippet:**

Three separate loops over identical bounds.

**Why inefficient:**

* Extra loop control overhead.  
* Multiple memory passes.  
* Redundant identity operation.

**Optimizations involved:**

* Loop fusion  
* Constant propagation  
* Dead code elimination

**Assembly snippets matching this behavior:**

**O0**

mov	DWORD PTR \-9644\[rbp\], 0

.L3:

mov	eax, DWORD PTR \-9644\[rbp\]

cdqe

mov	edx, DWORD PTR \-9644\[rbp\]

mov	DWORD PTR \-9616\[rbp+rax\*4\], edx

add	DWORD PTR \-9644\[rbp\], 1

**O1**

.L3:

mov	edx, DWORD PTR \[rsp+rax\]

lea	edx, \[rdx+rdx\*2\]

mov	DWORD PTR 3200\[rsp+rax\], edx

add	rax, 4

cmp	rax, 3200

jne	.L3

**O2**

.L3:

mov	ecx, DWORD PTR \[rsi+rax\]

lea	ecx, \[rcx+rcx\*2\]

mov	DWORD PTR \[rdx+rax\], ecx

add	rax, 4

cmp	rax, 3200

jne	.L3

**O3**

movdqa	xmm0, XMMWORD PTR \[rcx+rdx\]

pslld	xmm0, 1

paddd	xmm0, XMMWORD PTR \[rcx+rdx\]

movaps	XMMWORD PTR \[rax+rdx\], xmm0

**Os**

.L3:

imul	esi, DWORD PTR \[rdx+rax\], 3

add	rax, 4

mov	DWORD PTR \-4\[rax+rcx\], esi

cmp	rax, 3200

jne	.L3

**06\_inlining\_unrolling**

**Problematic snippet:**

s \+= square(arr\[i\]);

s \+= (arr\[i\] \* 2\) \- (arr\[i\] \* 2);

if (0) {

   s \+= c;

}

s \= s \* 1;

**Why inefficient:**

* Redundant arithmetic.  
* Dead branch.  
* Small fixed loop.

**Optimizations involved:**

* Function inlining  
* Loop unrolling  
* Constant folding  
* Dead code elimination

**Assembly snippets matching this snippet:**

**O0**

mov	eax, DWORD PTR \-48\[rbp+rax\*4\]

mov	edi, eax

call	square

cdqe

add	QWORD PTR \-88\[rbp\], rax

**O1**

.L4:

mov	eax, DWORD PTR \[rdx\]

imul	eax, eax

cdqe

add	rcx, rax

add	rdx, 4

cmp	rdx, rsi

jne	.L4

**O2**

.L5:

mov	eax, DWORD PTR \[rdx\]

add	rdx, 4

imul	eax, eax

cdqe

add	r8, rax

cmp	rdx, rcx

jne	.L5

**O3**

mov	edx, 1496

mov	edi, 1

xor	eax, eax

lea	rsi, .LC0\[rip\]

call	\_\_printf\_chk@PLT

**Os**

.L4:

mov	eax, DWORD PTR \[rcx+rdx\*4\]

inc	rdx

imul	eax, eax

cdqe

add	r8, rax

cmp	rdx, 16

jne	.L4

**07\_combined\_program\_1**

**Problematic snippet:**

int unused \= a \+ 100;

int z \= (x \* y) \+ (x \* y);

int p \= x \* 8;

for (int i \= 0; i \< n; i++) {

    sum \+= i \* n;

}

if (10 \> 20\) {

    sum \= 0;

}

**Why inefficient**:

* Unused variable (unused) has no effect.  
* Repeated subexpression (x\*y) appears twice.  
* Strength-reduction candidate (x\*8).  
* Constant-false branch is unreachable.  
* Loop is fully computable with constants.

**Optimizations involved:**

* Constant folding/propagation  
* Dead code elimination  
* Common subexpression elimination  
* Strength reduction  
* Branch elimination  
* Loop simplification / possible full loop removal

**Assembly snippets matching this snippet:**

**O0**

mov	DWORD PTR \-28\[rbp\], 200

mov	eax, DWORD PTR \-28\[rbp\]

add	eax, 100

mov	DWORD PTR \-24\[rbp\], eax

mov	eax, DWORD PTR \-20\[rbp\]

imul	eax, DWORD PTR \-16\[rbp\]

add	eax, eax

mov	DWORD PTR \-12\[rbp\], eax

**O1**

mov	eax, 100

.L3:

sub	eax, 1

jne	.L3

mov	edx, 505028

call	\_\_printf\_chk@PLT

**O2**

mov	edx, 505028

mov	edi, 1

xor	eax, eax

lea	rsi, .LC0\[rip\]

call	\_\_printf\_chk@PLT

**O3**

mov	edx, 505028

mov	edi, 1

xor	eax, eax

lea	rsi, .LC0\[rip\]

call	\_\_printf\_chk@PLT

**Os**

push	rax

mov	edx, 505028

lea	rsi, .LC0\[rip\]

xor	eax, eax

mov	edi, 1

call	\_\_printf\_chk@PLT

**08\_combined\_program\_2**

**Problematic snippet:**

for (int i \= 0; i \< n; i++) {

    int t \= i \* 4;

    sum \+= t \+ (i \* 4);

}

int useless \= sum \* 0;

int k \= 50 \* 2;

if (k \< 10\) {

    sum \= 1;

}

**Why inefficient:**

* Duplicate arithmetic (i\*4 repeated) inside loop.  
* useless is dead.  
* k is compile-time constant; branch is unreachable.  
* Large portions are simplifiable by constant and induction analysis.

**Optimizations involved:**

* Common subexpression elimination  
* Strength reduction / induction-variable optimization  
* Constant folding/propagation  
* Dead code elimination  
* Branch elimination  
* Loop optimization

**Assembly snippets matching this snippet:**

**O0**

mov	DWORD PTR \-8032\[rbp\], 1000

...

mov	eax, DWORD PTR \-8044\[rbp\]

lea	edx, \[rax+rax\]

...

mov	DWORD PTR \-8036\[rbp\], 100

cmp	DWORD PTR \-8036\[rbp\], 9

jle	.Lx

**O1**

mov	eax, 1000

.L2:

sub	eax, 1

jne	.L2

...

mov	edx, 3996000

call	\_\_printf\_chk@PLT

**O2**

mov	edx, 3996000

mov	edi, 1

xor	eax, eax

lea	rsi, .LC0\[rip\]

call	\_\_printf\_chk@PLT

**O3**

mov	edx, 3996000

mov	edi, 1

xor	eax, eax

lea	rsi, .LC0\[rip\]

call	\_\_printf\_chk@PLT

**Os**

push	rax

mov	edx, 3996000

lea	rsi, .LC0\[rip\]

xor	eax, eax

mov	edi, 1

call	\_\_printf\_chk@PLT

**14\. Final Consolidated Interpretation**

Across all 19 programs:

* O0 preserves structure.

* O1 removes obvious dead code.

* O2 provides strongest balanced improvements.

* O3 aggressively simplifies and may expand code.

* Os minimizes binary size effectively.

Observed patterns:

* Constant-heavy programs collapse to direct print at O2/O3.

* Loop-heavy programs benefit from invariant motion and induction simplification.

* Vectorization at O3 can increase instruction count.

* Os often matches O2 performance while minimizing size.


**15\. Conclusion**

The consolidated experiment demonstrates:

1. Compiler optimizations significantly reduce redundant instructions.

2. Control flow simplifies progressively with higher levels.

3. O2 remains the safest production default.

4. O3 benefits compute-heavy kernels.

5. Os is effective for size-constrained builds.

6. Early optimization passes enable deeper transformations.

This study confirms that GCC’s optimization pipeline compounds effects across passes, producing structurally simplified machine code at higher levels while preserving program semantics.