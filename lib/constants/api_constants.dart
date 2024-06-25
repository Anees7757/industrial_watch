String ipUrl = 'http://192.168.43.130:5000';

class ApiConstants {
  ApiConstants._cons();

  static ApiConstants? _ins;

  static ApiConstants get instance => _ins ??= ApiConstants._cons();

  String baseurl = '$ipUrl/api/';
}
