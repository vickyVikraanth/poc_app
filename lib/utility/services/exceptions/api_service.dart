import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../exceptions/exceptions.dart';
import 'dio_interceptor.dart';
import 'http_base.dart';

class ApiService implements HttpBase {
  Dio? _dio;

  @override
  void dispose() {
    _dio?.close();
  }

  @override
  Future<dynamic> deleteHttp(String route, body) async {
    Response response;
    try {
      final url = '${Client.baseUrl}$route';
      print('URL : $url');
      print('body : $body');
      _dio = Client().getDio(url);
      response = await _dio!.delete(
        url,
        data: body,
      );
      print('My Response : $response');
    } on DioError catch (error) {
      throw DataException.fromDioError(error);
    }
    return response.data;
  }

  @override
  Future<dynamic> getHttp(String route) async {
    Response response;
    try {
      final url = Client.baseUrl + route;
      _dio = Client().getDio(url);
      response = await _dio!.get(
        url,
      );
    } on DioError catch (error) {
      throw DataException.fromDioError(error);
    }
    return response.data;
  }

  @override
  Future<dynamic> postHttp(String route, body) async {
    Response response;
    try {
      final url = Client.baseUrl + route + "?";
      print('POST HTTP URL : $url');
      print('body : $body');
      _dio = Client().getDio(url);

      response = await _dio!.post(
        url,
        data: json.encode(body),
      );
    } on DioError catch (error) {
      throw DataException.fromDioError(error);
    }
    return response.data;
  }

  @override
  Future<dynamic> postHttpForm(
      String route, dynamic body, List<File>? files) async {
    Response response;
    try {
      final url = '${Client.baseUrl}$route';
      print('URL : $url');
      print('body : $body');
      _dio = Client().getDio(url);

      response = await _dio!.post(
        url,
        data: json.encode(body),
      );
      print('My Response : $response');
    } on DioError catch (e) {
      throw DataException.fromDioError(e);
    }

    return response.data;
  }

  @override
  Future<dynamic> postMultiFiles(
      {required String route,
      dynamic body,
      List<File>? files,
      bool isFieldsAdded = false}) async {
    Response response;
    try {
      final url = '${Client.baseUrl}$route';
      print('URL : $url');
      print('body : $body');
      _dio = Client().getDio(url);

      var formData = FormData();
      if (isFieldsAdded) {
        formData.fields.add(body);
      }
      if(files != null) {
        for (var file in files) {
          String fileName = file.path
              .split('/')
              .last;
          formData.files.addAll([
            MapEntry("image",
                await MultipartFile.fromFile(file.path, filename: fileName)),
          ]);
        }
      }

      response = await _dio!.post(
        url,
        data: formData,
      );
      print('My Response : $response');
    } on DioError catch (e) {
      throw DataException.fromDioError(e);
    }

    return response.data;
  }

  @override
  Future<dynamic> postOneFile(
      {required String route,
      dynamic body,
      File? file,
      bool isFieldsAdded = false}) async {
    Response response;
    try {
      final url = '${Client.baseUrl}$route';
      print('URL : $url');
      print('body : $body');
      _dio = Client().getDio(url);

      var formData = FormData();
      if (isFieldsAdded) {
        formData.fields.add(body);
      }
      if(file != null) {
        String fileName = file.path
            .split('/')
            .last;
        formData.files.add(
          MapEntry("image",
              await MultipartFile.fromFile(file.path, filename: fileName)),
        );
      }
      response = await _dio!.post(
        url,
        data: formData,
      );
      print('My Response : $response');
    } on DioError catch (e) {
      throw DataException.fromDioError(e);
    }

    return response.data;
  }
}
