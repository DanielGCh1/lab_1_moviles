import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Anime {
  final String title;
  final List<String> genres;
  final String coverImage;

  Anime({
    required this.title,
    required this.genres,
    required this.coverImage,
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
          genres
          coverImage {
            large
          }
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
        final List<String> genres = List<String>.from(anime['genres']);
        final String coverImage = anime['coverImage']['large'];

        animeList.add(Anime(
          title: title,
          genres: genres,
          coverImage: coverImage,
        ));
      }

      setState(() {
        this.animeList = animeList;
      });
    }
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
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(anime.coverImage),
                ),
                title: Text(anime.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: anime.genres.map((genre) => Text(genre)).toList(),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
