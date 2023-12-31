import 'dart:developer';

import 'package:dio/dio.dart';

import '../../constants.dart';

class DioHelper 
{
  static late Dio dio;

  // static String baseUrl = "https://10.0.2.2:7054/"; //Tested OK on Debug
  // static String baseUrl = "http://10.0.2.2:5109/";   //Tested OK on Run

  static Future<String> find_the_baseUrl() async 
  {
    // var res;
    Map? data = {};

    String host = "";

    if( IS_DEVELOPMENT_MODE)
    {
      //
      host = "https://10.0.2.2:7054/";
      data = await fetchData(host, "api/v2/ping");      
      if(data!["status"] == true) return host;

      host = "http://10.0.2.2:5000/";
      data = await fetchData(host, "api/v2/ping");
      if(data!["status"] == true) return host;

      host = "https://127.0.0.1:7054/";
      data = await fetchData(host, "api/v2/ping");      
      if(data!["status"] == true) return host;

      host = "http://127.0.0.1:5000/";
      data = await fetchData(host, "api/v2/ping");      
      if(data!["status"] == true) return host;

      host = "https://86e9-5-111-106-77.ngrok-free.app/";
      data = await fetchData(host, "api/v2/ping");      
      if(data!["status"] == true) return host;
    }
    
    host = "https://192.168.43.200/";
    data = await fetchData(host, "api/v2/ping");
    if(data!["status"] == true) return host;
    
    host = OUR_HOST;
    data = await fetchData(host, "api/v2/ping");
    if(data!["status"]??false == true) return host;

    return "NoConnection";
  }

  static init() async
  {

    BASE_URL = await find_the_baseUrl();
    log('Dio init() -------------------- ' + BASE_URL);
    
    
    dio = Dio(
      BaseOptions(
      baseUrl: BASE_URL, 
      receiveDataWhenStatusError: true,
    ));

  }

  static Future<Response> getData({
    required String url, 
    String? token, }) async 
  {

    dio.options.headers = {
      'token': token?? '',
    };

    return await dio.get(url);
  }

  static Future<Response> getDataWithBearerToken({
    required String url, String? token, }) async 
  {
    dio.options.headers = {
      'token': token ?? '',
      'Authorization': "Bearer " + token.toString(),
    };
    return await dio.get(url);
  }

  static Future<Response> getDataWithQuery({
    required String url, 
    String? token, 
    Map<String, dynamic>? query}) async 
  {
    dio.options.headers = {
      'token': token ?? '',
      'Authorization': "Bearer " + token.toString(),
    };
    
    return await dio.get(
      url, 
      queryParameters: query!.isEmpty ? null : query);
  }

  static Future<Response> postData({
      required String url, 
      required var data }) async 
  {
    dio.options.headers = {
      'Connection': 'keep-alive',
      "Content-Type": "application/json",
    };

    var res = await dio.post(url, data: data);
    return res;
  } //end postData

  static Future<Response> postDataWithImage(
      {required String url,
      dynamic length,
      String? token,
      //  String ?image,
      // Map<String, dynamic>? query,
      required var data}) async 
    {

    dio.options.headers = {
      // 'token':token??'',
      //'Accept':"application/json",
      //'Connection': 'keep-alive',
      //'Connection': 'keep-alive',
      'Authorization': "Bearer " + token.toString(),
      'Content-Type': 'multipart/form-data',
      'Content-Length': length,
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> postDataWithBearearToken(
    {required String url,
    String? token,
    required var data
    }) async 
    {

    dio.options.headers = {
      // 'token':token??'',
      // 'Accept':"application/json",
      // 'Content-Length':"132",
      'Authorization': "Bearer " + token.toString(),
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
    };
    log("post: ${ url.toString() }");
    var res = await dio.post(url, data: data);
    return res;
  }

  static Future<Map?> fetchData(String baseurl, String url) async 
  {

    log('================\nBaseURL: '+ baseurl + url);
    
    Dio dio1 = Dio(
        BaseOptions(
        baseUrl: baseurl, 
        receiveDataWhenStatusError: true,
        connectTimeout: Duration(seconds: 3),
        receiveTimeout: Duration(seconds: 3),
        sendTimeout: Duration(seconds: 3),
      ));

    // Dio dio1 = Dio();
    try{
      Response response = await dio1.get(url);
      log('ServerConnect OK ✅: ' + baseurl + url);
      // Process the response and return the data if successful
      return response.data;
    }catch( err ){      
      log('FAILED Server: ' + baseurl + url);
      log(err.toString());
    }
    return { };
  }
}
