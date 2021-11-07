class HttpException implements Exception {
    var massage;

  HttpException(this.massage);

  @override
  String toString() {
    return massage.toString();
  }
}
