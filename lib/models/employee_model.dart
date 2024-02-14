class Employee {
  int? id;
  String name;
  String section;
  int? productivity;
  String imageUrl;
  String email;
  String password;
  String role;
  String gender;
  String jobType;

  Employee({
    this.id,
    required this.name,
    required this.section,
    required this.email,
    required this.imageUrl,
    required this.gender,
    required this.jobType,
    required this.password,
    required this.role,
    this.productivity,
  });
}
