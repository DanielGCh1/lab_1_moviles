import 'package:flutter/material.dart';
import 'package:lab_1_moviles/your_anime_details_widget.dart';

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
                'Attack on Titan',
                'Your Name',
                'One Piece',
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
          ],
        ),
      ),
    );
  }
}
