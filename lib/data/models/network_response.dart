class NetworkResponse {
  final int statusCode;
  final dynamic responseData;
  final bool isSuccess;
  final String? errorMessage;

  NetworkResponse(
      {required this.statusCode,
      required this.isSuccess,
      this.responseData,
      this.errorMessage});
}
