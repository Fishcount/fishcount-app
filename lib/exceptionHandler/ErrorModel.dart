class ErrorModel {
  late String? message;
  late String? trace;
  late int? status;
  late List<String>? details;

  ErrorModel(
    this.message,
    this.trace,
    this.status,
    this.details,
  );

  ErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    trace = json['trace'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "trace": trace,
        "status": status,
        "details": details
      };
}
