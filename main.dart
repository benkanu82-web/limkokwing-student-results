import 'dart:io';

// ============================================================
// LIMKOKWING STUDENT RESULTS MANAGEMENT SYSTEM
// PROG 202 - SOFTWARE ENGINEERING ASSIGNMENT 1
//
// Programming Language: Dart
// Application Type: Console-Based Prototype
// Institution: Limkokwing University of Creative Technology
// ============================================================


// ============================================================
// 1. GRADE CALCULATOR
// ============================================================

String calculateGrade(double mark) {
  if (mark < 0 || mark > 100) {
    return 'Invalid';
  } else if (mark >= 80) {
    return 'A';
  } else if (mark >= 75) {
    return 'A-';
  } else if (mark >= 70) {
    return 'B+';
  } else if (mark >= 65) {
    return 'B';
  } else if (mark >= 60) {
    return 'B-';
  } else if (mark >= 55) {
    return 'C+';
  } else if (mark >= 50) {
    return 'C';
  } else if (mark >= 45) {
    return 'C-';
  } else if (mark >= 40) {
    return 'D';
  } else {
    return 'F';
  }
}


// ============================================================
// 2. MODULE CLASS
// ============================================================

class Module {
  String code;
  String name;

  Module({
    required this.code,
    required this.name,
  });
}


// ============================================================
// 3. STUDENT CLASS
// ============================================================

class Student {
  String studentId;
  String firstName;
  String lastName;
  String programme;
  int level;

  // Stores module code and mark
  Map<String, double> marks;

  Student({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.programme,
    required this.level,
    Map<String, double>? marks,
  }) : marks = marks ?? {};

  String get fullName => '$firstName $lastName';
}


// ============================================================
// 4. RESULTS MANAGEMENT SYSTEM CLASS
// ============================================================

class ResultsManagementSystem {
  final List<Student> students = [];
  final List<Module> modules = [];

  // ----------------------------------------------------------
  // REGISTER STUDENT
  // ----------------------------------------------------------

  void registerStudent() {
    printHeader('REGISTER STUDENT');

    String studentId = readRequiredText('Enter Student ID: ');

    // Check duplicate student ID
    if (findStudent(studentId) != null) {
      print('\nERROR: A student with this ID already exists.');
      return;
    }

    String firstName = readRequiredText('Enter First Name: ');
    String lastName = readRequiredText('Enter Last Name: ');
    String programme = readRequiredText('Enter Programme: ');

    int level = readPositiveInteger('Enter Level: ');

    Student student = Student(
      studentId: studentId,
      firstName: firstName,
      lastName: lastName,
      programme: programme,
      level: level,
    );

    students.add(student);

    print('\nSUCCESS: Student registered successfully.');
    print('Student ID: ${student.studentId}');
    print('Name: ${student.fullName}');
  }


  // ----------------------------------------------------------
  // REGISTER MODULE
  // ----------------------------------------------------------

  void registerModule() {
    printHeader('REGISTER MODULE');

    String code = readRequiredText('Enter Module Code: ').toUpperCase();

    // Check duplicate module
    if (findModule(code) != null) {
      print('\nERROR: A module with this code already exists.');
      return;
    }

    String name = readRequiredText('Enter Module Name: ');

    Module module = Module(
      code: code,
      name: name,
    );

    modules.add(module);

    print('\nSUCCESS: Module registered successfully.');
    print('Module Code: ${module.code}');
    print('Module Name: ${module.name}');
  }


  // ----------------------------------------------------------
  // RECORD STUDENT MARK
  // ----------------------------------------------------------

  void recordMark() {
    printHeader('RECORD STUDENT MARK');

    if (students.isEmpty) {
      print('No students have been registered yet.');
      return;
    }

    if (modules.isEmpty) {
      print('No modules have been registered yet.');
      return;
    }

    String studentId = readRequiredText('Enter Student ID: ');

    Student? student = findStudent(studentId);

    if (student == null) {
      print('\nERROR: Student not found.');
      return;
    }

    displayModules();

    String moduleCode =
        readRequiredText('Enter Module Code: ').toUpperCase();

    Module? module = findModule(moduleCode);

    if (module == null) {
      print('\nERROR: Module not found.');
      return;
    }

    double mark = readMark();

    bool isUpdating = student.marks.containsKey(moduleCode);

    student.marks[moduleCode] = mark;

    String grade = calculateGrade(mark);

    if (isUpdating) {
      print('\nSUCCESS: Student mark updated.');
    } else {
      print('\nSUCCESS: Student mark recorded.');
    }

    print('Student: ${student.fullName}');
    print('Module: ${module.code} - ${module.name}');
    print('Mark: ${formatMark(mark)}%');
    print('Grade: $grade');
  }


  // ----------------------------------------------------------
  // VIEW STUDENT RESULT
  // ----------------------------------------------------------

  void viewStudentResult() {
    printHeader('VIEW STUDENT RESULT');

    if (students.isEmpty) {
      print('No students have been registered.');
      return;
    }

    String studentId = readRequiredText('Enter Student ID: ');

    Student? student = findStudent(studentId);

    if (student == null) {
      print('\nERROR: Student not found.');
      return;
    }

    displayStudentResult(student);
  }


  // ----------------------------------------------------------
  // DISPLAY ALL STUDENTS
  // ----------------------------------------------------------

  void displayAllStudents() {
    printHeader('ALL REGISTERED STUDENTS');

    if (students.isEmpty) {
      print('No students have been registered.');
      return;
    }

    print(
      '${'ID'.padRight(15)}'
      '${'NAME'.padRight(25)}'
      '${'PROGRAMME'.padRight(25)}'
      'LEVEL',
    );

    print('-' * 80);

    for (Student student in students) {
      print(
        '${student.studentId.padRight(15)}'
        '${student.fullName.padRight(25)}'
        '${student.programme.padRight(25)}'
        '${student.level}',
      );
    }
  }


  // ----------------------------------------------------------
  // DISPLAY ALL MODULES
  // ----------------------------------------------------------

  void displayModules() {
    print('\nRegistered Modules:');

    if (modules.isEmpty) {
      print('No modules registered.');
      return;
    }

    print('-' * 60);

    for (Module module in modules) {
      print('${module.code} - ${module.name}');
    }

    print('-' * 60);
  }


  // ----------------------------------------------------------
  // DISPLAY STUDENT RESULT
  // ----------------------------------------------------------

  void displayStudentResult(Student student) {
    print('\n${'=' * 70}');
    print('                 STUDENT RESULT');
    print('=' * 70);

    print('Student ID : ${student.studentId}');
    print('Name       : ${student.fullName}');
    print('Programme  : ${student.programme}');
    print('Level      : ${student.level}');

    print('\n${'-' * 70}');

    if (student.marks.isEmpty) {
      print('No results have been recorded for this student.');
      print('=' * 70);
      return;
    }

    print(
      '${'MODULE'.padRight(15)}'
      '${'MODULE NAME'.padRight(30)}'
      '${'MARK'.padRight(10)}'
      'GRADE',
    );

    print('-' * 70);

    double total = 0;
    int count = 0;

    student.marks.forEach((moduleCode, mark) {
      Module? module = findModule(moduleCode);

      String moduleName =
          module?.name ?? 'Unknown Module';

      String markText = formatMark(mark);

      print(
        '${moduleCode.padRight(15)}'
        '${moduleName.padRight(30)}'
        '${markText.padRight(10)}'
        '${calculateGrade(mark)}',
      );

      total += mark;
      count++;
    });

    double average = total / count;

    print('-' * 70);
    print('Total Modules : $count');
    print('Average Mark  : ${average.toStringAsFixed(2)}%');
    print('Overall Grade  : ${calculateGrade(average)}');

    print('=' * 70);
  }


  // ----------------------------------------------------------
  // CLASS SUMMARY
  // ----------------------------------------------------------

  void displayClassSummary() {
    printHeader('CLASS SUMMARY');

    if (students.isEmpty) {
      print('No students have been registered.');
      return;
    }

    int studentsWithResults = 0;
    int totalMarksRecorded = 0;
    double totalMarks = 0;

    int gradeA = 0;
    int gradeAMinus = 0;
    int gradeBPlus = 0;
    int gradeB = 0;
    int gradeBMinus = 0;
    int gradeCPlus = 0;
    int gradeC = 0;
    int gradeCMinus = 0;
    int gradeD = 0;
    int gradeF = 0;

    for (Student student in students) {
      if (student.marks.isNotEmpty) {
        studentsWithResults++;

        for (double mark in student.marks.values) {
          totalMarks += mark;
          totalMarksRecorded++;

          String grade = calculateGrade(mark);

          switch (grade) {
            case 'A':
              gradeA++;
              break;

            case 'A-':
              gradeAMinus++;
              break;

            case 'B+':
              gradeBPlus++;
              break;

            case 'B':
              gradeB++;
              break;

            case 'B-':
              gradeBMinus++;
              break;

            case 'C+':
              gradeCPlus++;
              break;

            case 'C':
              gradeC++;
              break;

            case 'C-':
              gradeCMinus++;
              break;

            case 'D':
              gradeD++;
              break;

            case 'F':
              gradeF++;
              break;
          }
        }
      }
    }

    print('Total Registered Students : ${students.length}');
    print('Students With Results     : $studentsWithResults');
    print('Total Marks Recorded      : $totalMarksRecorded');

    if (totalMarksRecorded > 0) {
      double average = totalMarks / totalMarksRecorded;

      print(
        'Overall Average Mark      : '
        '${average.toStringAsFixed(2)}%',
      );

      print(
        'Overall Average Grade     : '
        '${calculateGrade(average)}',
      );
    }

    print('\nGRADE DISTRIBUTION');
    print('-' * 40);

    print('A   : $gradeA');
    print('A-  : $gradeAMinus');
    print('B+  : $gradeBPlus');
    print('B   : $gradeB');
    print('B-  : $gradeBMinus');
    print('C+  : $gradeCPlus');
    print('C   : $gradeC');
    print('C-  : $gradeCMinus');
    print('D   : $gradeD');
    print('F   : $gradeF');

    print('-' * 40);
  }


  // ----------------------------------------------------------
  // GRADE CALCULATOR
  // ----------------------------------------------------------

  void gradeCalculator() {
    printHeader('GRADE CALCULATOR');

    double mark = readMark();

    String grade = calculateGrade(mark);

    print('\nMark  : ${formatMark(mark)}%');
    print('Grade : $grade');
  }


  // ----------------------------------------------------------
  // DISPLAY GRADING SCALE
  // ----------------------------------------------------------

  void displayGradingScale() {
    printHeader('LIMKOKWING GRADING SCALE');

    print('${'MARK'.padRight(15)}GRADE');
    print('-' * 25);

    print('${'80 - 100'.padRight(15)}A');
    print('${'75 - 79'.padRight(15)}A-');
    print('${'70 - 74'.padRight(15)}B+');
    print('${'65 - 69'.padRight(15)}B');
    print('${'60 - 64'.padRight(15)}B-');
    print('${'55 - 59'.padRight(15)}C+');
    print('${'50 - 54'.padRight(15)}C');
    print('${'45 - 49'.padRight(15)}C-');
    print('${'40 - 44'.padRight(15)}D');
    print('${'0 - 39'.padRight(15)}F');

    print('-' * 25);
  }


  // ----------------------------------------------------------
  // FIND STUDENT
  // ----------------------------------------------------------

  Student? findStudent(String studentId) {
    for (Student student in students) {
      if (student.studentId.toLowerCase() ==
          studentId.toLowerCase()) {
        return student;
      }
    }

    return null;
  }


  // ----------------------------------------------------------
  // FIND MODULE
  // ----------------------------------------------------------

  Module? findModule(String moduleCode) {
    for (Module module in modules) {
      if (module.code.toLowerCase() ==
          moduleCode.toLowerCase()) {
        return module;
      }
    }

    return null;
  }


  // ----------------------------------------------------------
  // INPUT: REQUIRED TEXT
  // ----------------------------------------------------------

  String readRequiredText(String message) {
    while (true) {
      stdout.write(message);

      String input = stdin.readLineSync()?.trim() ?? '';

      if (input.isNotEmpty) {
        return input;
      }

      print('ERROR: This field cannot be empty.');
    }
  }


  // ----------------------------------------------------------
  // INPUT: POSITIVE INTEGER
  // ----------------------------------------------------------

  int readPositiveInteger(String message) {
    while (true) {
      stdout.write(message);

      String input = stdin.readLineSync()?.trim() ?? '';

      int? value = int.tryParse(input);

      if (value != null && value > 0) {
        return value;
      }

      print('ERROR: Please enter a valid positive number.');
    }
  }


  // ----------------------------------------------------------
  // INPUT: MARK
  // ----------------------------------------------------------

  double readMark() {
    while (true) {
      stdout.write('Enter Mark (0 - 100): ');

      String input = stdin.readLineSync()?.trim() ?? '';

      double? mark = double.tryParse(input);

      if (mark != null && mark >= 0 && mark <= 100) {
        return mark;
      }

      print(
        'ERROR: Invalid mark. '
        'Mark must be between 0 and 100.',
      );
    }
  }


  // ----------------------------------------------------------
  // FORMAT MARK
  // ----------------------------------------------------------

  String formatMark(double mark) {
    if (mark == mark.roundToDouble()) {
      return mark.toInt().toString();
    }

    return mark.toStringAsFixed(2);
  }


  // ----------------------------------------------------------
  // PRINT HEADER
  // ----------------------------------------------------------

  void printHeader(String title) {
    print('\n${'=' * 70}');
    print(title.padLeft((70 + title.length) ~/ 2));
    print('=' * 70);
  }


  // ----------------------------------------------------------
  // MAIN MENU
  // ----------------------------------------------------------

  void start() {
    bool running = true;

    while (running) {
      print('\n');
      print('=' * 70);
      print('        LIMKOKWING STUDENT RESULTS MANAGEMENT SYSTEM');
      print('=' * 70);

      print('1. Register Student');
      print('2. Register Module');
      print('3. Record Student Mark');
      print('4. View Student Result');
      print('5. Display All Students');
      print('6. Display All Modules');
      print('7. Display Class Summary');
      print('8. Calculate Grade');
      print('9. View Grading Scale');
      print('0. Exit');

      print('-' * 70);

      stdout.write('Enter your choice: ');

      String choice = stdin.readLineSync()?.trim() ?? '';

      switch (choice) {
        case '1':
          registerStudent();
          break;

        case '2':
          registerModule();
          break;

        case '3':
          recordMark();
          break;

        case '4':
          viewStudentResult();
          break;

        case '5':
          displayAllStudents();
          break;

        case '6':
          displayModules();
          break;

        case '7':
          displayClassSummary();
          break;

        case '8':
          gradeCalculator();
          break;

        case '9':
          displayGradingScale();
          break;

        case '0':
          print('\nThank you for using LSRMS.');
          print('Goodbye!');
          running = false;
          break;

        default:
          print(
            '\nERROR: Invalid choice. '
            'Please select an option from 0-9.',
          );
      }
    }
  }
}


// ============================================================
// 5. PROGRAM ENTRY POINT
// ============================================================

void main() {
  ResultsManagementSystem system =
      ResultsManagementSystem();

  system.start();
}