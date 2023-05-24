import 'package:flutter/material.dart';
import 'package:lab_1_moviles/utils/Queries.dart';
import '../widgets/AnimeDetails.dart';

class AnimeScreen extends StatefulWidget {
  @override
  _AnimeScreenState createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  List<String> listAnimes = [];

  @override
  void initState() {
    super.initState();
    getListAnimesQuery().then((animes) {
      setState(() {
        listAnimes = animes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listAnimes.length,
        itemBuilder: (context, index) {
          final anime = listAnimes[index];
          return ListTile(
            title: Text(anime),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeDetails(animeTitle: anime),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
