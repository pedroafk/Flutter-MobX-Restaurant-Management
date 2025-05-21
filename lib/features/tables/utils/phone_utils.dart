String formatPhone(String value) {
  String digits = value.replaceAll(RegExp(r'\D'), '');
  String formatted = digits;
  if (digits.length >= 2) {
    formatted = '(${digits.substring(0, 2)})';
    if (digits.length >= 7) {
      formatted +=
          ' ${digits.substring(2, 7)}-${digits.substring(7, digits.length > 11 ? 11 : digits.length)}';
    } else if (digits.length > 2) {
      formatted += ' ${digits.substring(2)}';
    }
  }
  return formatted;
}
