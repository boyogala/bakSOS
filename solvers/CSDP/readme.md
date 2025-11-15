This is the project page for the CSDP project of COIN-OR.

CSDP is a library of routines that implements a predictor corrector variant of the semidefinite programming algorithm of Helmberg, Rendl, Vanderbei, and Wolkowicz. The main advantages of this code are that it is written to be used as a callable subroutine, it is written in C for efficiency, the code runs in parallel on shared memory multi-processor systems, and it makes effective use of sparsity in the constraint matrices. CSDP has been compiled on many different systems. The code should work on any system with an ANSI C Compiler and BLAS/LAPACK libraries.

Detailed descriptions of CSDP and its parallel version can be found in the following papers.

B. Borchers. CSDP, A C Library For Semidefinite Programming. Optimization Methods and Software 11(1):613-623, 1999. Preprint

B. Borchers. CSDP 2.3 User's Guide Optimization Methods and Software 11(1):597-611, 1999. Preprint

B. Borchers and J. G. Young. Implementation of a primal-dual method of a primal-dual method for SDP on a shared memory parallel architecture Computational Optimization and Applications 37(3):355-369, 2007. Preprint

CSDP has been used as an SDP solver within a number of other research projects. A list of publications in which CSDP has been used is available.

The SDPLIB collection of test problems in semidefinite programming can be used to test your installation of CSDP.

The current version of the CSDP User's Guide is also available.

The most recent stable version of CSDP is 6.2.0. Precompiled binary version of CSDP for Windows and Linux are available:

CSDP 6.2.0 for 64 bit Windows 7, 8, 10

CSDP 6.2.0 for x86_64 Linux

Please contact the author, borchers@nmt.edu, if you need a binary version for some other computer architecture/OS.

You can obtain a copy of the source code of version 6.2.0 by downloading a compressed tar archive Instructions for building and installing CSDP can be found in the INSTALL file in the top-level Csdp directory.

If you want to access the most recent development version of CSDP, then you can obtain a copy by first installing the git tools on your system and then using the git command:

git clone https://github.com/coin-or/Csdp.git
CSDP depends on high-performance BLAS and LAPACK libraries. I've written a blog posting about how to use BLAS and LAPACK on Linux

Associated with the project is a Google Group for discussion of the use of CSDP Or, you can contact the author by email borchers@nmt.edu.

Several software packages have built on CSDP or interfaced CSDP to other programming languages:

Ivan D. Ivanov at TU Delft has also modified an earlier version of CSDP for use on a distributed memory system. His version of CSDP is available at http://lyrawww.uvt.nl/~edeklerk/PCSDP/.

Hector Corrada Bravo has developed an interface between R and CSDP.

Benjamin Kern is developing a Python interface to CSDP.

Benoit Legat and Elias Kuthe have developed A Julia interface to CSDP.

