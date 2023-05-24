import 'package:flutter/material.dart';
import 'package:lab_1_moviles/utils/queries.dart';

import '../widgets/AnimeListByGenre.dart';

class GenreScreen extends StatefulWidget {
  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  List<String> listGenres = [];

  @override
  void initState() {
    super.initState();
    fetchGenreCollection().then((genres) {
      setState(() {
        listGenres = genres;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listGenres.length,
        itemBuilder: (context, index) {
          final genre = listGenres[index];
          return ListTile(
            title: Text(genre),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeListByGenre(genre: genre),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
