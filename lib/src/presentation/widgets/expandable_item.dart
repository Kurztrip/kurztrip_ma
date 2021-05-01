import 'package:flutter/material.dart';

class ExpandableItem {
  ExpandableItem({
    @required this.expandedValue,
    @required this.title,
    this.subtitle,
    this.isExpanded = false,
  });

  String title;
  String subtitle;
  Map<String, dynamic> expandedValue;
  bool isExpanded;
}
