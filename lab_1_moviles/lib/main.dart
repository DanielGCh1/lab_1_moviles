import 'package:flutter/material.dart';
import 'package:lab_1_moviles/your_anime_details_widget.dart';

import 'AnimeListByGenreWidget.dart'; // Importar el nuevo archivo

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laboratorio #1',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.blueGrey, // Fondo púrpura
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false, // Oculta el banner de "debug"
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedAnime;
  String? selectedGenre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laboratorio #1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedAnime,
              hint: Text('Seleccione un anime'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedAnime = newValue;
                });
              },
              items: <String>[
                'Kimetsu no Yaiba',
                'Your Name',
                'Naruto',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedAnime != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeDetailsWidget(
                        animeTitle: selectedAnime!,
                      ),
                    ),
                  );
                }
              },
              child: Text('Ver detalles del anime seleccionado'),
            ),
            DropdownButton<String>(
              value: selectedGenre,
              hint: Text('Seleccione un genero'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGenre = newValue;
                });
              },
              items: <String>[
                'Action',
                'Comedy',
                'Adventure',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AnimeListByGenreWidget(genre: selectedGenre),
                  ),
                );
              },
              child: Text('Ver lista de animes por género'),
            ),
          ],
        ),
      ),
    );
  }
}
