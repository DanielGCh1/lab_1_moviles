import 'package:flutter/material.dart';
import 'package:lab_1_moviles/widgets/AnimeDetails.dart';

//ignore: must_be_immutable
class WatchSelectedAnime extends StatelessWidget {
  final String? selectedAnime;
  double? heig;

  WatchSelectedAnime(
      {this.selectedAnime, required this.heig});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        onPressed: () {
          if (selectedAnime != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnimeDetails(
                  animeTitle: selectedAnime!,
                ),
              ),
            );
          }
        },
        child: Text('Ver detalles del anime seleccionado'),
      ),
      SizedBox(
        height: heig,
      ),
    ]);
  }
}