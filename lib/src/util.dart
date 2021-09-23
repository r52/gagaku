extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return '';

    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
