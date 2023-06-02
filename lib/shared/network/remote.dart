import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static String baseUrl = "https://10.0.2.2:7054/";

  static init() {
    //TODO: fix it to the reals server.
    print('Dio init() -----------------------------------------');
    dio = Dio(BaseOptions(
      // baseUrl: "http://127.0.0.1:5000/",
      baseUrl: "https://10.0.2.2:7054/", //Tested OK
      
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url, String? token, }) async 
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
    return await dio.get(url, queryParameters: query!.isEmpty ? null : query);
  }
  /* static Future<Response> getDataWithQuery(
      {required String url,
       required Map<String,dynamic>query,
      }) async {
    return await dio.get(url,queryParameters: query);
  }*/

  static Future<Response> postData({
      required String url, required var data }) async 
  {
    dio.options.headers = {
      'Connection': 'keep-alive',
      "Content-Type": "application/json",
    };
    // print(dio1.options.baseUrl + url);
    

    //TODO: remove prints
    print('-44444444444444444-3-3');    
    var res = await dio.post(url, data: data);
    return res;
  } //end postData

  static Future<Response> postDataWithImage(
      {required String url,
      dynamic length,
      String? token,
      //  String ?image,
      // Map<String, dynamic>? query,
      required var data}) async {
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
      //  String ?image,
      // Map<String, dynamic>? query,
      }) async {
    dio.options.headers = {
      // 'token':token??'',
      // 'Accept':"application/json",
      // 'Content-Length':"132",
      'Authorization': "Bearer " + token.toString(),
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
    };
    var res = await dio.post(url, data: data);
    print(res);
    return res;
  }
}
