import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bigul/service/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<dynamic> get(String endpoint) async {
    debugPrint('get called $endpoint');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    try {
      final response = await http.get(Uri.parse(endpoint), headers: headers);
      debugPrint("get response code: ${response.statusCode}");
      return _response(response);
    } on SocketException {
      throw FetchDataException(999, 'No Internet Connection');
    } on TimeoutException {
      throw FetchDataException(999, 'Try again, slow internet connection!');
    }
  }

  Future<dynamic> post(String endpoint, var body) async {
    debugPrint('post called $endpoint');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    try {
      final response = await http.post(Uri.parse(endpoint),
          headers: headers, body: jsonEncode(body));
      debugPrint("post String response code: ${response.statusCode}");
      return _response(response);
    } on SocketException {
      throw FetchDataException(999, 'No Internet Connection');
    } on TimeoutException {
      throw FetchDataException(999, 'Try again, slow internet connection!');
    }
  }

  Future<dynamic> put(String endpoint, [var body]) async {
    debugPrint('put called $endpoint');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    try {
      final response = await http.put(Uri.parse(endpoint),
          headers: headers, body: jsonEncode(body));
      debugPrint("put String response code: ${response.statusCode}");
      return _response(response);
    } on SocketException {
      throw FetchDataException(999, 'No Internet Connection');
    } on TimeoutException {
      throw FetchDataException(999, 'Try again, slow internet connection!');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    debugPrint('delete called $endpoint');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    try {
      final response = await http.delete(Uri.parse(endpoint), headers: headers);
      debugPrint("delete String response code: ${response.statusCode}");
      return _response(response);
    } on SocketException {
      throw FetchDataException(999, 'No Internet Connection');
    } on TimeoutException {
      throw FetchDataException(999, 'Try again, slow internet connection!');
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        debugPrint("Status code - ${response.statusCode} : $responseJson");
        return responseJson;

      case 301:
        var responseJson = jsonDecode(response.body.toString());
        debugPrint("Status code - ${response.statusCode} : $responseJson");
        throw UnauthorisedException(
            response.statusCode, responseJson['message']);

      case 400:
      case 401:
      case 402:
      case 404:
      case 405:
        var responseJson = jsonDecode(response.body.toString());
        debugPrint("Status code - ${response.statusCode} : $responseJson");
        throw BadRequestException(response.statusCode, responseJson['message']);

      case 500:
      case 502:
        if (kDebugMode) {
          debugPrint(response.body.toString());
        }
        debugPrint("Status code - ${response.statusCode} : $response");
        throw ServerError(response.statusCode, "");

      default:
        if (kDebugMode) {
          debugPrint(response.body.toString());
        }
        debugPrint("Status code - ${response.statusCode} : $response");
        throw FetchDataException(
            response.statusCode, 'Error! StatusCode : ${response.statusCode}');
    }
  }
}
