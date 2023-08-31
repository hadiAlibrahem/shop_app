

import 'package:dio/dio.dart';

class DioHelper {

  static late Dio dio;

  static init() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          setRequestContentTypeWhenNoPayload: true,
          validateStatus: (_) => true,
          //contentType: Headers.jsonContentType,
          responseType:ResponseType.json,

        )
    );
  }

  static Future<Response<dynamic>?> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang='en',
    String? token,
  }) async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    final result=await dio.get(url,queryParameters: query);
    return  result;//await dio?.get(url,queryParameters: query);
  }
  static Future<Response<dynamic>?>postData({
    required String url,
     Map<String, dynamic> ?query,
    required Map<String,dynamic>data,
    String lang='en',
    String? token,
})async
{
  dio.options.headers=
  {
    'Content-Type':'application/json',
    'lang':lang,
    'Authorization':token,
  };
  return dio.post(
      url,
      queryParameters:query,
      data:data,
  );
}

  static Future<Response<dynamic>?>putData({
    required String url,
    Map<String, dynamic> ?query,
    required Map<String,dynamic>data,
    String lang='en',
    String? token,
  })async
  {
    dio.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return dio.put(
      url,
      queryParameters:query,
      data:data,
    );
  }

}
//  static init() {
//    dio = Dio(
//      BaseOptions(
//        baseUrl: 'https://newsapi.org/',
//        receiveDataWhenStatusError: true,
//
//      ),
//    );
//    print('date get');
//  }
//
//    // ignore: unused_element
//    static Future<Response> getData({
//      required String url,
//      required  Map<String,dynamic>query,
//
//    }) async
//  {
//    Options (
//      validateStatus: (_) => true,
//      contentType: Headers.jsonContentType,
//      responseType:ResponseType.json,
//    );
//
//    Options (validateStatus: (_) => true);
//     return await dio!.get(
//         url,
//         queryParameters:query,
//
//
//     );
//  }}




