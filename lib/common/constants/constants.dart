class Constants {
  static RegExp phoneRegExp =
      RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
  static const baseUrl = 'http://10.0.2.2:3000';
}
