import 'dart:ui';

class CurrentUser {
  CurrentUser({required this.displayName, required this.color});

  String displayName;
  Color color;

  String abbrev() {
    return displayName.substring(0, 14);
  }
}