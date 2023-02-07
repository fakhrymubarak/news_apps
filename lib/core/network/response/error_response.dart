class ErrorResponse {
  ErrorResponse({
    required this.status,
    required this.code,
    required this.message,
  });

  final String status;
  final String code;
  final String message;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
  );
}
