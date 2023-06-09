import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lab_1_moviles/widgets/CharacterList.dart';
import 'package:lab_1_moviles/utils/Queries.dart';
import 'Models.dart';
import '../utils/Api.dart';

class AnimeListByGenre extends StatefulWidget {
  final String? genre;

  AnimeListByGenre({required this.genre});

  @override
  _AnimeListByGenreState createState() => _AnimeListByGenreState();
}

class _AnimeListByGenreState extends State<AnimeListByGenre> {
  late List<Anime> animeList;
  String? selectedGenre;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.genre;
    animeList = [];
    fetchAnimeList();
  }

  Future<void> fetchAnimeList() async {
    final query = fetchAnimeListQuery(selectedGenre);

    try {
      final response = await sendGraphQLRequest(query);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final media = data['data']['Page']['media'];

        final List<Anime> fetchedAnimeList = [];

        for (final anime in media) {
          final String title = anime['title']['romaji'];
          final String coverImage = anime['coverImage']['large'];
          final int episodes = anime['episodes'];
          final String status = anime['status'];
          final double averageScore = anime['averageScore']?.toDouble() ?? 0.0;

          fetchedAnimeList.add(Anime(
            title: title,
            coverImage: coverImage,
            episodes: episodes,
            status: status,
            averageScore: averageScore,
          ));
        }

        setState(() {
          animeList = fetchedAnimeList;
        });
      }
    } catch (error) {
      print('Error fetching anime list: $error');
    }
  }

  void navigateToCharacterList(String animeTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterListWidget(animeTitle: animeTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (animeList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Género: ${widget.genre}')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: animeList.length,
            itemBuilder: (context, index) {
              final anime = animeList[index];
              return GestureDetector(
                onTap: () => navigateToCharacterList(anime.title),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: Container(
                      width: 100,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(anime.coverImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(anime.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Episodios: ${anime.episodes}"),
                      Text("Estado: ${anime.status}"),
                      Text("Puntuación promedio: ${anime.averageScore}"),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
