import 'package:flutter/material.dart';
import 'package:lab_1_moviles/utils/queries.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemCount: listAnimes.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 8),
          itemBuilder: (BuildContext context, int index) {
            final anime = listAnimes[index];
            return Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(179, 231, 236, 236),
                borderRadius: BorderRadius.circular(10), // Redondear los bordes
                //border: Border.all(color: Colors.cyan), // Agregar un borde
              ),
              child: ListTile(
                title: Text(
                  anime,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeDetails(animeTitle: anime),
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
