abstract class FieldValidator {
  static String? isNotEmpty(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    return null;
  }
}
