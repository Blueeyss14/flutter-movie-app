import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconComponent {
  Icon sosmedIcon;
  String sosmedName;

  IconComponent({
    required this.sosmedIcon, required this.sosmedName,
});

  static List<IconComponent> dataIcon() {
    return [
      IconComponent(
          sosmedIcon: const Icon(FontAwesomeIcons.instagram),
          sosmedName: "bluee.art14__",
      ),
      IconComponent(
        sosmedIcon: const Icon(FontAwesomeIcons.github),
        sosmedName: "Blueeyss14",
      ),
      IconComponent(
        sosmedIcon: const Icon(Icons.exit_to_app),
        sosmedName: "Exit",
      ),
    ];
  }
}