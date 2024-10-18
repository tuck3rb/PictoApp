import 'dart:ui';

class CurrentUser {
  CurrentUser({required this.displayName, required this.color});

  String displayName;
  Color color;

  // Modified `abbrev` to not crash when display name is short
  String abbrev() {
    if (displayName.length <= 14) {
      return displayName;
    } else {
      return displayName.substring(0, 14);
    }
  }
}