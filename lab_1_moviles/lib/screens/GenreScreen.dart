import 'package:flutter/material.dart';
import 'package:lab_1_moviles/utils/Queries.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemCount: listGenres.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 8),
          itemBuilder: (BuildContext context, int index) {
            final genre = listGenres[index];
            return Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(179, 231, 236, 236),
                borderRadius: BorderRadius.circular(10), // Redondear los bordes
                //border: Border.all(color: Colors.lightBlueAccent),
              ),
              child: ListTile(
                title: Text(genre),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeListByGenre(genre: genre),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
