import 'dart:async';
import 'dart:convert';
import 'package:flutter_demo_app/model/anime_model.dart';
import 'package:flutter_demo_app/model/api_model.dart';
import 'package:flutter_demo_app/strings/app_strings.dart';
import 'package:http/http.dart' as http;

final _tokenURL = AppStrings.baseUrl + AppStrings.tokenEndpoint;
final _animeURL = AppStrings.animeUrl;

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
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

Future<List<Anime>> getAnimeList(String query) async {
  var queryParams = {'q': query};
  var uri = Uri.http(_animeURL, '/q', queryParams);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Anime.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}
