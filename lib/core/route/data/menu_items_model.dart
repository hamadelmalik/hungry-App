class MenuItemModel {
  final int id;
  final String title;
  final String icon;
  final String route;

  MenuItemModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      route: json['route'],
    );
  }
}