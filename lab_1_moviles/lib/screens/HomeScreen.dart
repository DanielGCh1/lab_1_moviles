import 'package:flutter/material.dart';
import 'package:lab_1_moviles/screens/AnimeScreen.dart';
import 'package:lab_1_moviles/screens/GenreScreen.dart';
import 'package:lab_1_moviles/screens/HomeTab.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('G2 ANIME'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Inicio'),
              Tab(text: 'Anime'),
              Tab(text: 'Géneros'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeTab(),
            AnimeScreen(),
            GenreScreen(),
          ],
        ),
      ),
    );
  }
}
