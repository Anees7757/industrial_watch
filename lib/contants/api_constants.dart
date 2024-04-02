class ApiConstants {
  ApiConstants._cons();
  static ApiConstants? _ins;
  static ApiConstants get instance => _ins ??= ApiConstants._cons();

  String baseurl = 'http://192.168.0.103:5000/api/';
}
