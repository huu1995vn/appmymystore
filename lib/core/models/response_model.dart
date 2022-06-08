class ResponseModel {
  final dynamic data;
  final String message;
  final int status;

  ResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });
  ResponseModel.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        message = json['message'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'data': data,
        'message': message,
        'status': status,

      };
}
