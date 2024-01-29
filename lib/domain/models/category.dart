class CustomTreeNode {
  const CustomTreeNode();
}

class Category extends CustomTreeNode {
  final String id;
  final DateTime createdAt;
  final String displayText;
  final String imageUrl;

  const Category({
    required this.id,
    required this.createdAt,
    required this.displayText,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at']),
      displayText: json['display_text'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'display_text': displayText,
      'image_url': imageUrl,
    };
  }
}
