import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo_app/model/anime_model.dart';
import 'package:flutter_demo_app/repository/remote/api_connection.dart';
import 'package:http/http.dart' as http;


class AnimeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Anime>>(
      future:  getAnimeList("https://api.jikan.moe/v3/search/anime?q=naruto"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Anime> data = snapshot.data;
          return _jobsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }


  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].position, data[index].company, Icons.work);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}