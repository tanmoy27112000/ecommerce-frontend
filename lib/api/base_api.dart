// ignore_for_file: inference_failure_on_function_invocation, strict_raw_type

import 'package:alice/alice.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:ecommerce/global/constant.dart';
import 'package:flutter/foundation.dart';

String token = '';
String baseApi = '';

Alice alice = Alice(
  showNotification: false,
  showInspectorOnShake: kDebugMode,
);

class ApiHelper {
  ApiHelper() {
    setUpOptions();
  }
  ApiHelper._privateConstructor();
  static final ApiHelper _instance = ApiHelper._privateConstructor();

  static ApiHelper get instance => _instance;
  Dio _dio = Dio();

  //dio getter
  Dio get dio => _dio;

  late BaseOptions baseOptions;

  Future<void> setUpOptions() async {
    baseOptions = BaseOptions(
      baseUrl: baseApi,
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
      validateStatus: (status) {
        return status! < 500;
      },
    );
    _dio = Dio(baseOptions);
    _dio.interceptors.add(alice.getDioInterceptor());

    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: (message) {
          logger.d('RETRY ====== $message');
        }, // specify log function (optional)
        retryDelays: const [
          // set delays between retries (optional)
          Duration(seconds: 1), // wait 1 sec before first retry
          Duration(seconds: 2), // wait 2 sec before second retry
          Duration(seconds: 3), // wait 3 sec before third retry
        ],
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers.putIfAbsent("Authorization", () => "Bearer $token");
          return handler.next(options);
        },
      ),
    );
  }

//*GET API CALL
  Future<Response<dynamic>> getRequest(String path) async {
    try {
      final result = await _dio.get(
        path,
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

//* POST API CALL
  Future<Response<dynamic>> postRequest(
    String uri, {
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

//PUT Api call

  Future<Response<dynamic>> putRequest(
    String uri, {
    required Map data,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  //DELETE Api call

  Future<Response<dynamic>> deleteRequest(
    String uri,
  ) async {
    try {
      final response = await _dio.delete(
        uri,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
