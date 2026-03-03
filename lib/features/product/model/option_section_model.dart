class OptionSection {
  final int id;
  final String name;
  final List<String> items;

  OptionSection({
    required this.id,
    required this.name,
    required this.items,
  });

  factory OptionSection.fromJson(Map<String, dynamic> json) {
    return OptionSection(
      id: json['id'],
      name: json['name'],
      items: List<String>.from(json['items']),
    );
  }
}