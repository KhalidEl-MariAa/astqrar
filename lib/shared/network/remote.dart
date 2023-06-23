import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants.dart';

class DioHelper 
{
  static late Dio dio;

  static String baseUrl = "https://10.0.2.2:7054/"; //Tested OK on Debug
  // static String baseUrl = "http://10.0.2.2:5109/";   //Tested OK on Run

  static Future<String> find_the_baseUrl() async 
  {
    var res;
    String baseurl ="";
    Map? data = {};

    log("IS_DEVELOPMENT_MODE: ${IS_DEVELOPMENT_MODE}, kReleaseMode: ${kReleaseMode}");

    if( IS_DEVELOPMENT_MODE)
    {
      baseurl = "https://10.0.2.2:7054/";
      data = await fetchData(baseurl, "api/v2/ping");      
      if(data!["status"] == true) return baseurl;

      baseurl = "http://10.0.2.2:5109/";
      data = await fetchData(baseurl, "api/v2/ping");
      if(data!["status"] == true) return baseurl;
    }
        
    baseurl = BASE_URL;
    data = await fetchData(baseurl, "api/v2/ping");
    if(data!["status"]??false == true) 
      log(res.toString());
    else
      log("FAILED with BASE_URL: ${BASE_URL}");

    return baseurl;
  }

  static init() async
  {
    
    DioHelper.baseUrl = await find_the_baseUrl();
    log('Dio init() -------------------- ' + baseUrl);
    
    
    dio = Dio(
      BaseOptions(
      baseUrl: baseUrl, 
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
    
    return await dio.get(
      url, 
      queryParameters: query!.isEmpty ? null : query);
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
    log("token: ${token.toString()}");
    var res = await dio.post(url, data: data);
    print(res);
    return res;
  }

  static Future<Map?> fetchData(String baseurl, String url) async 
  {

    log('================\n Try BaseURL: '+ baseurl + url);
    
    Dio dio1 = Dio(
        BaseOptions(
        baseUrl: baseurl, 
        receiveDataWhenStatusError: true,
        connectTimeout: 3000,
        receiveTimeout: 3000,
        sendTimeout: 3000,
      ));

    // Dio dio1 = Dio();
    try{
      Response response = await dio1.get(url);
      log('Connection OK: ' + baseurl + url);
      // Process the response and return the data if successful
      return response.data;
    }catch( err){
      log('Connection FAILED: ' + baseurl + url);
    }
    return {};
  }
}
