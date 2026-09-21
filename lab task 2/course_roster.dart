/// Course Roster Console App — Lab 1
/// Fill in each TODO. Run after every part to check your output.

void main(List<String> args) {
  // ---------- Part 1: Setup & Welcome ----------
  printWelcome('Course Roster Manager');

  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();
  String courseTitle = 'CS201: Mobile App Development';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;
  List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];
  Set<String> waitlist = {'Priya', 'Noah'};
  Map<String, int> attendanceCount = {'Aiden': 3, 'Maria': 4, 'Jamal': 2};

  print(
    '$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}',
  );

  print('Created at: $createdAt');
  String? instructorEmail;
  print(instructorEmail ?? 'TBA');

  late String enrollmentCode;
  enrollmentCode = generateCode(courseTitle);
  print('Enrollment code: $enrollmentCode');

  print(instructorEmail?.length ?? 'Email is null');

  String rawNames = ' Aiden , maria ,JAMAL , Priya ';
  List<String> cleanNames = [];
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }
  print(cleanNames);

  String description =
      '''
Course: $courseTitle
Credits: $creditHours
Status: ${isOpen ? 'Open' : 'Closed'}
''';
  print(description);

  print('Seats left: ${capacity - enrolledStudents.length}');
  // ~/ and %
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;
  print('Full groups of 3: $fullGroups, leftover: $leftover');

  // is / is!
  Object formInput = 'twenty-two';
  if (formInput is String) print('This is text!');
  if (formInput is! int) print('Not a number.');

  // cascade ..
  var report = StringBuffer()
    ..write(courseTitle)
    ..write(' | Cap: $capacity')
    ..write(' | Roster: ${enrolledStudents.length}');
  print('Report: ${report.toString()}');

  // null-safe cascade ?..
  List<String>? extraNotes;
  extraNotes?..add('Room change pending');
  print('Extra notes: $extraNotes');

  // ??=
  int? bonusSeats;
  bonusSeats ??= 0;
  print('Bonus seats: $bonusSeats');
  // if/else
  if (isOpen && enrolledStudents.length < capacity) {
    print("You're in! Welcome aboard.");
  } else {
    print('Sorry, course is full.');
  }

  // switch
  int enrollmentStatusCode = 200;
  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown error');
  }

  // ternary
  String statusTag = isOpen ? 'OPEN' : 'FULL';
  print(statusTag);
  // for-in
  for (var student in enrolledStudents) {
    print(student);
  }

  // forEach
  attendanceCount.forEach((key, value) {
    print('$key: $value');
  });

  // collection literal with embedded if/for
  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL — waitlist open',
    for (var student in waitlist)
      'Reminder: $student, please confirm attendance',
  ];

  for (var announcement in announcements) {
    print(announcement);
  }
}

/// Prints a welcome banner for the given [appName].
void printWelcome(String appName) {
  print('=== $appName ===');
}

String generateCode(String title) =>
    title.substring(0, 2).toUpperCase() + '101';
