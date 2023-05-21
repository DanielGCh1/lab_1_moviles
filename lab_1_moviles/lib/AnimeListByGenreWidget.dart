import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'your_character_list_widget.dart';

class Anime {
  final String title;
  final String coverImage;
  final int episodes;
  final String status;
  final double averageScore;

  Anime({
    required this.title,
    required this.coverImage,
    required this.episodes,
    required this.status,
    required this.averageScore,
  });
}

class AnimeListByGenreWidget extends StatefulWidget {
  final String? genre;

  AnimeListByGenreWidget({required this.genre});

  @override
  _AnimeListByGenreWidgetState createState() => _AnimeListByGenreWidgetState();
}

class _AnimeListByGenreWidgetState extends State<AnimeListByGenreWidget> {
  late List<Anime> animeList = [];
  String? selectedGenre;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.genre;
    fetchAnimeList();
  }

  Future<void> fetchAnimeList() async {
    final query = '''
    query {
      Page {
        media(type: ANIME, genre: "${selectedGenre ?? ""}") {
          title {
            romaji
          }
          coverImage {
            large
          }
          episodes
          status
          averageScore
        }
      }
    }
    ''';

    final response = await http.post(
      Uri.parse('https://graphql.anilist.co/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'query': query}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final media = data['data']['Page']['media'];

      final List<Anime> animeList = [];

      for (final anime in media) {
        final String title = anime['title']['romaji'];
        final String coverImage = anime['coverImage']['large'];
        final int episodes = anime['episodes'];
        final String status = anime['status'];
        final double averageScore = anime['averageScore']?.toDouble() ?? 0.0;

        animeList.add(Anime(
          title: title,
          coverImage: coverImage,
          episodes: episodes,
          status: status,
          averageScore: averageScore,
        ));
      }

      setState(() {
        this.animeList = animeList;
      });
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
        appBar: AppBar(title: Text("Animes por género")),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: animeList.length,
            itemBuilder: (context, index) {
              final anime = animeList[index];
              return GestureDetector(
                onTap: () => navigateToCharacterList(anime.title),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(anime.coverImage),
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
