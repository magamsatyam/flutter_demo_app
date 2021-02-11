import 'package:flutter_demo_app/exception/custom_exception.dart';
import 'package:flutter_demo_app/model/api_model.dart';
import 'package:flutter_demo_app/strings/app_strings.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class ApiProvider {

  final _tokenURL = AppStrings.baseUrl + AppStrings.tokenEndpoint;

  Future<dynamic> getAnimeList(String url) async {
    var responseJson;
    try {
      final response = await http.get(url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  Future<Token> getToken(UserLogin userLogin) async {
    print(_tokenURL);
    final response = await http.post(
      _tokenURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userLogin.toDatabaseJson()),
    );
    if (response.statusCode == 200) {
      return Token.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
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