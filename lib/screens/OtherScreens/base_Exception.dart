class BaseException{
  String? message;

  BaseException({this.message});
  BaseException.checkCod(int statusCode){
    switch(statusCode){
      case 401 :
        throw BaseException(message: 'Unauthorized');

      case 404 :
        throw BaseException(message: 'File Not Found');

      case 500:
        throw BaseException(message: 'Internal Server Error');

      case 408:
        throw BaseException(message: 'Time Out');

      default :
        throw BaseException();

    }
  }
}