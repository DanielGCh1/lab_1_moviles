import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab_1_moviles/your_anime_details_widget.dart';
import 'AnimeListByGenreWidget.dart'; // Importar el nuevo archivo
import 'package:lab_1_moviles/widgets/DropDownList.dart';

import 'package:lab_1_moviles/utils/queries.dart';
import 'package:lab_1_moviles/widgets/WatchSelectedAnime.dart';
import 'package:lab_1_moviles/widgets/WatchAnimesByGeneres.dart';

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
  String selectedAnime = "";
  String selectedGenre = "";

  List<String> listAnimes = [
    'Kimetsu no Yaiba',
    'Your Name',
    'Naruto',
    'Shingeki no Kyojin',
  ];

  final GlobalKey<DropdownListState> dropDownListAnimes = GlobalKey();

  void updateDropdownListAnimes(
      List<String> newList, String newSelectedOption) {
    final dropdownList = dropDownListAnimes.currentState;
    setState(() {
      dropdownList!.updateValues(newList, newSelectedOption);
    });
  }

  List<String> listGenres = [
    'Action',
    'Comedy',
    'Adventure',
  ];

  final GlobalKey<DropdownListState> dropDownListGenres = GlobalKey();

  void updateDropdownListGenres(
      List<String> newList, String newSelectedOption) {
    final dropdownList = dropDownListGenres.currentState;
    setState(() {
      dropdownList!.updateValues(newList, newSelectedOption);
    });
  }

  @override
  void initState() {
    super.initState();
    selectedGenre = listGenres[0];
    fetchGenreCollection().then((genres) {
      setState(() {
        listGenres = genres;
        selectedGenre = listGenres[0];
        updateDropdownListGenres(listGenres, selectedGenre);
      });
    });
    selectedAnime = listAnimes[0];
    getListAnimesQuery().then((animes) {
      setState(() {
        listAnimes = animes;
        selectedAnime = listAnimes[0];
        updateDropdownListAnimes(listAnimes, selectedAnime);
      });
    });
  }

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
            DropdownList(
                list: listAnimes,
                key: dropDownListAnimes,
                selectedOption: selectedAnime ?? "",
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAnime = newValue ?? "";
                  });
                },
                title: 'Seleccione un anime',
                heig: 20),
            /*
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
                'Shingeki no Kyojin',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),*/
            WatchSelectedAnime(selectedAnime: selectedAnime, heig: 20),
/*
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
            SizedBox(
              height: 20,
            ),*/
            DropdownList(
                list: listGenres,
                key: dropDownListGenres,
                selectedOption: selectedGenre ?? "",
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGenre = newValue ?? "";
                  });
                },
                title: 'Seleccione un genero',
                heig: 20),
            /*
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
            ),*/
            WatchAnimesByGeneres(selectedGenre: selectedGenre, heig: 20)
            /*,
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
            ),*/
          ],
        ),
      ),
    );
  }
}
