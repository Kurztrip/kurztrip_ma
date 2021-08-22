class Organization {
  const Organization(
      {required this.id,
      required this.name,
      required this.createAt,
      required this.users});
  final int id;
  final String name;
  final DateTime createAt;
  final List<String> users;
}
