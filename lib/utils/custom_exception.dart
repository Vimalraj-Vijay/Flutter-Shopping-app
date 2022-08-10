class CustomException implements Exception {
  var message = "";

  CustomException(this.message);

  @override
  String toString() {
    return message;
  }
}
