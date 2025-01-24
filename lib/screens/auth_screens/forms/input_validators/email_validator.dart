class EmailValidator{
  static final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  static String? validate(String? email, Map<String, bool> statusMap) {
    if (email == null || email.isEmpty) {
      statusMap['isWrongInputEmail'] = true;
      return "Введіть електронну адресу.";
    }

    if (!emailRegex.hasMatch(email)) {
      statusMap['isWrongInputEmail'] = true;
      return "Введіть коректну електронну адресу.";
    }

    statusMap['isWrongInputEmail'] = false;
    return null;
  }
}