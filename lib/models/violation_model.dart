class Violation {
  int? id;
  String title;
  String date;
  String time;
  List<String> images;
  int empId;

  Violation({
    this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.images,
    required this.empId,
  });
}
