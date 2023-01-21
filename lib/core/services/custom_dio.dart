import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

import '../../constants/keys.dart';
import 'api_paths.dart';

class CustomDio {
  Future<dynamic> request(String endPoint, {bool outOfApi=false ,body, String serverPath = "EndPoint.SERVER_PATH", Map<String, dynamic>? headers, String? type}) async {
    Map<String, dynamic>? _basicheaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    Response response;
    final Dio dio = Dio();
    final options = Options(
      headers: headers==null?_basicheaders:headers,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );


    try {
      switch (type) {

        //**************** GET Request ********************** */
        case RequestType.Get:
          {
            log('hello from get');
            print(endPoint);
            response = await dio.get(
              endPoint,
              options: options,
            );
          }
          break;
        //**************** Post Request ********************** */
        case RequestType.Post:
          {
            print('hello from post');
            print(serverPath + endPoint);
            response = await dio.post(
              outOfApi?endPoint:"$serverPath$endPoint",
              data: body ?? {},
              options: options,
            );
          }
          break;
        //**************** Put Request ********************** */
        case RequestType.Put:
          {
            response = await dio.put(serverPath + endPoint, data: body ?? {}, options: options);
          }
          break;
        //**************** Delete Request ********************** */
        case RequestType.Delete:
          {
            response = await dio.delete(serverPath + endPoint, data: body ?? {}, options: options);
          }
          break;
        //**************** default is get Request ********************** */
        default:
          response = await dio.get(
            serverPath + endPoint.toString(),
          );
          break;
      }

      print("status code for $endPoint   =========${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      }
    } on DioError catch (e) {
      print('🌐🌐ERROR in http $type for $endPoint:🌐🌐\n' + e.toString());
      
      if (e.message.contains("SocketException")) {
        print('No Internet connection 😑');
        //* go to no page and continue call api again
        Keys.navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => Container()/*NoInternet()*/)).then((value) {
          request(endPoint, body: body, headers: headers, serverPath: serverPath, type: type);
        });
        throw CustomDioException("No Internet connection !", 404);
        //* if token is invalid
      } else if (e.response == null || e.response?.data["message"] == "Unauthenticated." || e.response?.statusCode == 401) {
        //*go to login page again
        Keys.navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Container()/*LoginView()*/), (route) => false);

        throw CustomDioException("Session is not authenticated", 401);
      } else {
        throw CustomDioException(e.response?.data["message"] ?? "Bad Network Or Server Not available now", e.response!.statusCode ?? 500);
      }
    }
    
  }

  //**************** upload File ********************** */
  Future<Response> uploadFile({
    required String path,
    required String filePath,
    void Function(int received, int total)? sendProgress,
    List<Map<String, String>>? body,
    CancelToken? cancelToken,
  }) async {
    final File file = File(filePath);
    final Dio dio = Dio();
    final fileName = basename(file.path);
    final FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    if (body != null) {
      final x = body.map((e) => MapEntry(e.keys.first, e.values.first));
      data.fields.addAll(x);
    }

    final Response response = await dio.post(path, data: data, onSendProgress: sendProgress, cancelToken: cancelToken);
    _throwIfNoSuccess(response);
    return response;
  }
  //**************** upload Files ********************** */

  Future<Response> uploadFiles({
    required String path,
    required List<DioUploadFileModel> filesModel,
    void Function(int received, int total)? sendProgress,
    List<Map<String, String>>? body,
    CancelToken? cancelToken,
  }) async {
    final mapOfData = <String, dynamic>{};
    final Dio dio = Dio();

    for (final file in filesModel) {
      final _file = File(file.filePath);
      final fileName = basename(_file.path);
      mapOfData.addAll({
        file.fileFiledName: await MultipartFile.fromFile(
          _file.path,
          filename: fileName,
        ),
      });
    }
    final formData = FormData.fromMap(mapOfData);

    if (body != null) {
      final x = body.map((e) => MapEntry(e.keys.first, e.values.first));
      formData.fields.addAll(x);
    }
    final Response response = await dio.post(path, data: formData, onSendProgress: sendProgress, cancelToken: cancelToken);

    _throwIfNoSuccess(response);
    return response;
  }

  void _throwIfNoSuccess(Response response) {
    if (response.statusCode == 401) {
      // go to login again
    }
    if (response.statusCode! > 300) {
      final errorMsg = response.data["message"];
      throw CustomDioException(errorMsg, response.statusCode ?? 500);
    }
  }
}

class DioUploadFileModel {
  final String filePath;
  final String fileFiledName;

  const DioUploadFileModel({required this.filePath, required this.fileFiledName});
}

class CustomDioException implements Exception {
  dynamic data;
  int code;

  CustomDioException(this.data, this.code);

  @override
  String toString() {
    return data.toString();
  }
}
