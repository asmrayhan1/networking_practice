class CategoryModel {
  String? id;
  String? name;
  String? description;

  DateTime? createdAt;
  DateTime? updatedAt;

  bool? isDeleted;

  CategoryModel({
    this.id,
    this.name,
    this.description,

    this.createdAt,
    this.updatedAt,

    this.isDeleted = false
  });

  // fromJson method to convert JSON to CategoryModel object
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],

      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null
    );
  }

  // toJson method to convert RegisterModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String()
    };
  }
}