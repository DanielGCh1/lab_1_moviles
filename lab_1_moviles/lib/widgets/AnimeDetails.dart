import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lab_1_moviles/utils/Queries.dart';

import '../utils/Api.dart';

class Anime {
  final String title;
  final String startDate;
  final String endDate;
  final int episodes;
  final int duration;
  final String status;
  final List<String> genres;
  final double averageScore;
  final String coverImage;
  final List<Character> characters;

  Anime({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.episodes,
    required this.duration,
    required this.status,
    required this.genres,
    required this.averageScore,
    required this.coverImage,
    required this.characters,
  });
}

class Character {
  final String name;
  final String gender;
  final String dateOfBirth;
  final String image;

  Character({
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.image,
  });
}

class AnimeDetails extends StatefulWidget {
  final String animeTitle;

  AnimeDetails({required this.animeTitle});

  @override
  _AnimeDetailsState createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  late Anime anime;

  @override
  void initState() {
    super.initState();
    anime = Anime(
      title: '',
      startDate: '',
      endDate: '',
      episodes: 0,
      duration: 0,
      status: '',
      genres: [],
      averageScore: 0,
      coverImage: '',
      characters: [],
    );
    fetchAnimeDetails(widget.animeTitle);
  }

  void fetchAnimeDetails(String title) async {
    final response = await sendGraphQLRequest(fetchAnimeDetailsQuery(title));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final media = data['data']['Media'];

      final List<Character> characters =
          (media['characters']['edges'] as List).map((edge) {
        final character = edge['node'];
        final String name = character['name']['full'] ?? "";
        final String gender = character['gender'] ?? 'Desconocido';
        final Map<String, dynamic> dateOfBirth = character['dateOfBirth'];
        final int month = dateOfBirth['month'] ?? 0;
        final int day = dateOfBirth['day'] ?? 0;
        final String image = character['image']['large'] ?? "";

        return Character(
          name: name,
          gender: gender,
          dateOfBirth: (month != 0 && day != 0) ? '$month-$day' : 'Desconocido',
          image: image,
        );
      }).toList();

      setState(() {
        anime = Anime(
          title: media['title']['romaji'] ?? "",
          startDate:
              '${media['startDate']['year']}-${media['startDate']['month']}-${media['startDate']['day']}',
          endDate:
              '${media['endDate']['year']}-${media['endDate']['month']}-${media['endDate']['day']}',
          episodes: media['episodes'] ?? 0,
          duration: media['duration'] ?? 0,
          status: media['status'] ?? "",
          genres: List<String>.from(media['genres']) ?? [],
          averageScore: media['averageScore'].toDouble() ?? 0,
          coverImage: media['coverImage']['large'] ?? "",
          characters: characters,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(anime.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            (anime.coverImage.isNotEmpty)
                ? Image.network(anime.coverImage)
                : SizedBox(height: 5.0),
            SizedBox(height: 5.0),
            Text(
              'Informacion:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text('Fecha Inicio: ${anime.startDate}'),
            Text('Fecha Finalizacion: ${anime.endDate}'),
            Text('Episodios: ${anime.episodes}'),
            Text('Duracion: ${anime.duration} minutes'),
            Text('Estado: ${anime.status}'),
            Text('Generos: ${anime.genres.join(", ")}'),
            Text('Calificacion: ${anime.averageScore}'),
            SizedBox(height: 16.0),
            Text(
              'Personajes:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: anime.characters.length,
              itemBuilder: (context, index) {
                final character = anime.characters[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character.image),
                  ),
                  title: Text(character.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (character.gender != 'Desconocido')
                        Text('Gender: ${character.gender}'),
                      if (character.dateOfBirth != 'Desconocido')
                        Text('Date of Birth: ${character.dateOfBirth}'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
