# MIPS IBAN Calculator

This repository contains a MIPS assembly project that implements a German IBAN calculator. The application converts a German bank account number (Kontonummer, KNR) and bank code (Bankleitzahl, BLZ) to a standardized IBAN format, and can also extract the KNR and BLZ from an existing IBAN.

## Project Overview

The utility demonstrates how to manage string manipulations and arithmetic calculations in assembly language, offering an insightful peek into low-level programming and data handling.

## Features

- **IBAN Conversion:** Convert KNR and BLZ into a German IBAN.
- **IBAN Extraction:** Extract KNR and BLZ from a given IBAN.
- **Modular Design:** The codebase is organized into separate files, each handling a distinct part of the IBAN processing.

## Implementation Details

The program is divided into multiple tasks, with each subroutine placed in its own file for ease of management and understanding:

- **Input Validation:** Checks that input KNR and BLZ adhere to expected formats.
- **Checksum Calculation:** Responsible for calculating the checksum required for generating a valid IBAN.
- **Format Assembly:** Assembles the final IBAN format following the German banking standards.

## Getting Started

To run this project, you'll need a MIPS simulator like MARS or QtSpim. Detailed setup and execution instructions are provided within each subroutine file, which guide you through the process of running and testing the program.

## Learn More

For an introduction to IBANs, visit the [International Bank Account Number](https://en.wikipedia.org/wiki/International_Bank_Account_Number) on Wikipedia.


