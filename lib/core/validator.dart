class InputValidator {
  static InputValidator? _instance;

  InputValidator._initialize();

  static InputValidator get instance =>
      _instance ??= InputValidator._initialize();

  String? validateIsNull(String? value, String returnMessage) {
    if (value == null || value.isEmpty) {
      return returnMessage;
    }
    return null;
  }

  String? validateIsNullTrimmed(String? value, String returnMessage) {
    if (value == null || value.trim().isEmpty) {
      return returnMessage;
    }
    return null;
  }
}
