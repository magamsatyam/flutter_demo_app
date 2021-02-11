
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/ui/widgets/anime_list.dart';


class AnimList extends StatelessWidget{
  static const String routeName = '/animeList';
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: AnimeListView(),
   );
  }
}