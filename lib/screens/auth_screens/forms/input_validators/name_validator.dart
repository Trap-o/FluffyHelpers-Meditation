class NameValidator{

  static String? validate(String? username, Map<String, bool> statusMap) {
    if (username == null || username.isEmpty) {
      statusMap['isWrongInputName'] = true;
      return "Введіть ім'я.";
    }

    if (username.length < 2) {
      statusMap['isWrongInputName'] = true;
      return "Ім'я користувача має містити хоча б два символи.";
    }

    statusMap['isWrongInputName'] = false;
    return null;
  }
}