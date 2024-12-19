class LoginModel {
  String? data;

  LoginModel({
    this.data
  });

  // fromJson method to convert JSON to RegisterModel object
  factory LoginModel.fromJson(String json) {
    return LoginModel(
      data: json
    );
  }

  // toJson method to convert RegisterModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': data
    };
  }
}
