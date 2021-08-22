class ExpandableItem {
  ExpandableItem({
    required this.expandedValue,
    required this.title,
    required this.id,
    this.subtitle,
    this.isExpanded = false,
  });
  int? id;
  String title;
  String? subtitle;
  Map<String, dynamic> expandedValue;
  bool isExpanded;
}
