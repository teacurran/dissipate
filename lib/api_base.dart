import 'dart:async' as dart_async;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class ApiResponse<T> {
  Status status;

  T? data;

  String? message;

  ApiResponse.loading(this.message) : status = Status.loadingStatus;

  ApiResponse.completed(this.data) : status = Status.completedStatus;

  ApiResponse.error(this.message) : status = Status.errorStatus;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { loadingStatus, completedStatus, errorStatus }

class ApiBase {
  final String _baseUrl = dotenv.get("API_BASE_URL",
      fallback: "https://gffft-auth.appspot.com/api/");

  String getBaseUrl() {
    return _baseUrl;
  }

  Future<dynamic> get(String urlPath,
      {bool requireAuth = false, Map<String, String>? queryParams}) async {
    return callApi(urlPath, requireAuth: requireAuth, queryParams: queryParams);
  }

  Future<dynamic> post(String urlPath, String jsonPayload) async {
    return callApi(urlPath,
        method: "post",
        payload: jsonPayload,
        payloadContentType: "application/json");
  }

  Future<dynamic> patch(String urlPath, String jsonPayload) async {
    return callApi(urlPath,
        method: "patch",
        payload: jsonPayload,
        payloadContentType: "application/json");
  }

  Future<dynamic> put(String urlPath, String jsonPayload) async {
    return callApi(urlPath,
        method: "put",
        payload: jsonPayload,
        payloadContentType: "application/json");
  }

  Future<dynamic> delete(String urlPath, String? jsonPayload) async {
    return callApi(urlPath,
        method: "delete",
        payload: jsonPayload,
        payloadContentType: "application/json");
  }

  Future<dynamic> callApi(String urlPath,
      {String method = "get",
      bool requireAuth = false,
      String? payload,
      String? payloadContentType,
      Map<String, String>? queryParams}) async {

    var url = Uri.parse(_baseUrl + urlPath);
    if (queryParams != null) {
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = '$url?$queryString';

      url = Uri.parse(requestUrl);
    }

    url = Uri.parse(Uri.encodeFull(url.toString()));

    if (kDebugMode) {
      print('Api $method, url $url');
    }

    dynamic responseJson;
    try {
      final request = http.Request(method, url);
      // this causes:
      // Uncaught DeferredLoadException: 'Loading main.dart.js_1.part.js failed: the code with hash 'JLmiu+O5NLuJN+WqCynEyvC4lPA=' was not loaded.
      // event log:
      // final fbUser = await fbAuth.authStateChanges().first;

      // but this does not always seem to be initialized
      final fbUser = null; //fbAuth.currentUser;

      if (requireAuth && fbUser == null) {
        throw FetchDataException('User must be authenticated');
      }

      if (fbUser != null) {
        final String token = await fbUser.getIdToken(false);
        if (kDebugMode) {
          print('auth token: $token');
        }
        request.headers.addAll({
          "Authorization": "Bearer $token",
        });
      }

      if (payload != null) {
        if (kDebugMode) {
          print("Sending payload: $payload");
        }
        request.body = payload;
      }

      if (payloadContentType != null) {
        request.headers.addAll({'Content-Type': payloadContentType});
      }

      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 403) {
        await fbAuth.signOut();
      }
      responseJson = returnResponse(response);
    } catch (e, stacktrace) {
      if (e is SocketException) {
        //treat SocketException
        if (kDebugMode) {
          print("Socket exception: ${e.toString()}");
        }
      } else if (e is dart_async.TimeoutException) {
        //treat TimeoutException
        if (kDebugMode) {
          print("Timeout exception: ${e.toString()}");
        }
      } else if (kDebugMode) {
        print("Unhandled exception. signing user out.: ${e.toString()}");
        //await fbAuth.signOut();
      }

      throw FetchDataException('Unable to fetch data');
    }
    if (kDebugMode) {
      print("response: $responseJson");
    }
    return responseJson;
  }

  Future<dynamic> getAuthenticated(String urlPath,
      {Map<String, String>? queryParams}) async {
    return callApi(urlPath, requireAuth: true, queryParams: queryParams);
  }

  Future<dynamic> postAuthenticated(String urlPath,
      {Map<String, String>? queryParams}) async {
    return callApi(urlPath,
        method: "post", requireAuth: true, queryParams: queryParams);
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        if (kDebugMode) {
          print(responseJson);
        }
        return responseJson;
      case 204:
        return null;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
