import 'package:http/http.dart';

class MyResponse<T> {
  final Response response;
  final T? responseData;

  const MyResponse({
    required this.response,
    this.responseData,
  });
}
