import 'package:flutter/material.dart';
import 'package:lab_1_moviles/AnimeListByGenreWidget.dart';

//ignore: must_be_immutable
class WatchAnimesByGeneres extends StatelessWidget {
  final String? selectedGenre;
  double? heig;

  WatchAnimesByGeneres({this.selectedGenre, required this.heig});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      SizedBox(
        height: heig,
      ),
    ]);
  }
}
