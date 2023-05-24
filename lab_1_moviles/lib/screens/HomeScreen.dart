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
            labelColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Inicio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ), // Establece el grosor de la fuente y el tamaño
              ),
              Tab(
                child: Text(
                  'Animes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ), // Establece el grosor de la fuente y el tamaño
              ),
              Tab(
                child: Text(
                  'Géneros',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ), // Establece el grosor de la fuente y el tamaño
              ),
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
