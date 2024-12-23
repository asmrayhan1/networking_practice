class TaskModel {
  String? id;
  String? title;
  String? description;
  bool? completed;
  Object? categories;

  DateTime? createdAt;
  DateTime? updatedAt;

  bool? isDeleted;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.completed,
    this.categories,

    this.createdAt,
    this.updatedAt,

    this.isDeleted = false
  });

  // fromJson method to convert JSON to CategoryModel object
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        completed: json['completed'] ?? false,
        categories: json['categories']?? null,

        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
        updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null
    );
  }

  // toJson method to convert RegisterModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed' : completed,
      'categories' : categories,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String()
    };
  }
}