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

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      section: json['section'],
      productivity: json['productivity'],
      imageUrl: json['imageUrl'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      gender: json['gender'],
      jobType: json['jobType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'section': section,
      'productivity': productivity,
      'imageUrl': imageUrl,
      'email': email,
      'password': password,
      'role': role,
      'gender': gender,
      'jobType': jobType,
    };
  }
}
