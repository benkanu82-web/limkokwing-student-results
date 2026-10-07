# Limkokwing Student Results Management System (LSRMS)

A console-based prototype for managing student records, module registration, and examination results, written in **Dart**.

> **Course:** PROG 202 – Software Engineering
> **Assignment:** 1
> **Institution:** Limkokwing University of Creative Technology
> **Student:** _Your Name_ (_Your Student ID_)

---

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Grading Scale](#grading-scale)
4. [Requirements](#requirements)
5. [Getting Started](#getting-started)
6. [Usage](#usage)
7. [Project Structure](#project-structure)
8. [Input Validation](#input-validation)
9. [Known Limitations](#known-limitations)
10. [Future Improvements](#future-improvements)

---

## Overview

LSRMS lets an administrator register students and modules, record marks, and view results. Letter grades are calculated automatically from the Limkokwing grading scale. The system also produces a class summary with an overall average and a grade distribution.

All data is held in memory while the program runs.

## Features

- **Register students** with ID, first name, last name, programme, and level (duplicate IDs are rejected)
- **Register modules** with a code and a name (duplicate codes are rejected)
- **Record and update marks** per student per module
- **View an individual student result** with per-module grades, average mark, and overall grade
- **List all registered students** in a formatted table
- **List all registered modules**
- **Class summary** showing totals, overall average, and grade distribution (A to F)
- **Standalone grade calculator** for any mark between 0 and 100
- **Grading scale reference** from the main menu
- Case-insensitive lookup of student IDs and module codes

## Grading Scale

| Mark      | Grade |
|-----------|-------|
| 80 – 100  | A     |
| 75 – 79   | A-    |
| 70 – 74   | B+    |
| 65 – 69   | B     |
| 60 – 64   | B-    |
| 55 – 59   | C+    |
| 50 – 54   | C     |
| 45 – 49   | C-    |
| 40 – 44   | D     |
| 0 – 39    | F     |

## Requirements

- [Dart SDK](https://dart.dev/get-dart) 2.12 or later (null safety required)
- A terminal or command prompt

Check your installation:

```bash
dart --version
```

## Getting Started

1. Save the source file, for example as `lsrms.dart`.
2. Open a terminal in the same folder.
3. Run the program:

```bash
dart run lsrms.dart
```

Optionally, compile it to a native executable:

```bash
dart compile exe lsrms.dart -o lsrms
./lsrms
```

## Usage

When the program starts, the main menu appears:

```
======================================================================
        LIMKOKWING STUDENT RESULTS MANAGEMENT SYSTEM
======================================================================
1. Register Student
2. Register Module
3. Record Student Mark
4. View Student Result
5. Display All Students
6. Display All Modules
7. Display Class Summary
8. Calculate Grade
9. View Grading Scale
0. Exit
```

### Suggested workflow

1. **Register at least one module** (option 2), e.g. `PROG202` – `Software Engineering`.
2. **Register at least one student** (option 1).
3. **Record marks** (option 3). Entering a mark again for the same module updates the existing one.
4. **View results** (option 4) or the **class summary** (option 7).

### Example result output

```
======================================================================
                 STUDENT RESULT
======================================================================
Student ID : LU1001
Name       : Aminata Kamara
Programme  : Software Engineering
Level      : 2

----------------------------------------------------------------------
MODULE         MODULE NAME                   MARK      GRADE
----------------------------------------------------------------------
PROG202        Software Engineering          78        A-
----------------------------------------------------------------------
Total Modules : 1
Average Mark  : 78.00%
Overall Grade : A-
======================================================================
```

## Project Structure

The program is a single Dart file organised into these parts:

| Component                  | Type     | Responsibility                                               |
|----------------------------|----------|--------------------------------------------------------------|
| `calculateGrade()`         | Function | Converts a numeric mark into a letter grade                  |
| `Module`                   | Class    | Holds a module code and name                                 |
| `Student`                  | Class    | Holds student details and a map of module code to mark       |
| `ResultsManagementSystem`  | Class    | Contains all features, input helpers, and the main menu loop |
| `main()`                   | Function | Program entry point                                          |

## Input Validation

- Required text fields cannot be empty
- Level must be a positive whole number
- Marks must be numeric and between 0 and 100
- Duplicate student IDs and module codes are rejected
- Marks cannot be recorded for unknown students or modules
- Invalid menu choices show an error and return to the menu

## Known Limitations

- **No persistence:** all data is lost when the program exits
- **Simple average:** the overall grade is an unweighted average and does not consider module credit hours
- **Single user:** there is no login or role-based access
- **Console only:** there is no graphical interface

## Future Improvements

- Save and load data using JSON or CSV files
- Add credit hours to modules and compute a weighted GPA
- Support editing and deleting students, modules, and marks
- Add authentication for administrators and lecturers
- Export result slips to PDF
- Add unit tests for grade calculation and validation
- Build a Flutter front end on top of the same logic

## License

This project was created for educational purposes as part of a university assignment.