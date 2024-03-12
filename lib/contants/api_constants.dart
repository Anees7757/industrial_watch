class ApiConstants {
  ApiConstants._cons();
  static ApiConstants? _ins;
  static ApiConstants get instance => _ins ??= ApiConstants._cons();

  String baseurl = 'https://jsonplaceholder.typicode.com/';
  String path = 'users';
}
