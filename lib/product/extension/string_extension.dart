
extension CapitalizeFirstLetterExtension on String? {
  String? capitalizeFirstLetter() {
    if (this == null || this!.isEmpty) {
      return this;
    }
    return this!.substring(0, 1).toUpperCase() + this!.substring(1).toLowerCase();
  }
}