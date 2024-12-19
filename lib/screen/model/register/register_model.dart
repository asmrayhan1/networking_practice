class RegisterModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  DateTime? createdAt;
  DateTime? updatedAt;

  RegisterModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,

    this.createdAt,
    this.updatedAt,
  });

  // fromJson method to convert JSON to RegisterModel object
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],

      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // toJson method to convert RegisterModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
