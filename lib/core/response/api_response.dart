class ApiResponse{
  int status;
  String message;
  Object data;

  ApiResponse({required this.status, required this.message, required this.data});

  // fromJson method to convert JSON to ApiResponse object
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],  // Assuming data is dynamic; could be a specific type if known
    );
  }

  // toJson method to convert ApiResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,  // This will need to be adjusted if 'data' is a complex type
    };
  }


}