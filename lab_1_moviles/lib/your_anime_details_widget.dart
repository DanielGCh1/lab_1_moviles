import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final List<Character> characters; // Lista de personajes

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

class AnimeDetailsWidget extends StatefulWidget {
  final String animeTitle;

  AnimeDetailsWidget({required this.animeTitle});

  @override
  _AnimeDetailsWidgetState createState() => _AnimeDetailsWidgetState();
}

class _AnimeDetailsWidgetState extends State<AnimeDetailsWidget> {
  late Anime anime;

  @override
  void initState() {
    super.initState();
    fetchAnimeDetails(widget.animeTitle);
  }

  Future<void> fetchAnimeDetails(String title) async {
    final query = '''
    query {
      Media(search: "$title", type: ANIME) {
        title {
          romaji
          english
          native
        }
        startDate {
          year
          month
          day
        }
        endDate {
          year
          month
          day
        }
        episodes
        duration
        status
        genres
        averageScore
        coverImage {
          large
        }
        characters {
          edges {
            node {
              name {
                full
              }
              gender
              dateOfBirth {
                month
                day
              }
              image {
                large
              }
            }
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
      final media = data['data']['Media'];

      final List<Character> characters = [];

      // Obtener la lista de personajes
      final List<dynamic> characterEdges = media['characters']['edges'];
      for (int i = 0; i < 3 && i < characterEdges.length; i++) {
        final character = characterEdges[i]['node'];
        final String name = character['name']['full'];
        final String? gender = character['gender'];
        final Map<String, dynamic> dateOfBirth = character['dateOfBirth'];
        final int? month = dateOfBirth['month'];
        final int? day = dateOfBirth['day'];
        final String image = character['image']['large'];

        characters.add(Character(
          name: name,
          gender: gender ?? 'Desconocido',
          dateOfBirth:
              month != null && day != null ? '$month-$day' : 'Desconocido',
          image: image,
        ));
      }
      /*
      for (final edge in characterEdges) {
        final character = edge['node'];
        final String name = character['name']['full'];
        final String? gender = character['gender'];
        final Map<String, dynamic> dateOfBirth = character['dateOfBirth'];
        final int? month = dateOfBirth['month'];
        final int? day = dateOfBirth['day'];
        final String image = character['image']['large'];

        characters.add(Character(
          name: name,
          gender: gender ?? 'Desconocido',
          dateOfBirth:
              month != null && day != null ? '$month-$day' : 'Desconocido',
          image: image,
        ));
      }
      */

      setState(() {
        anime = Anime(
          title: media['title']['romaji'],
          startDate:
              '${media['startDate']['year']}-${media['startDate']['month']}-${media['startDate']['day']}',
          endDate:
              '${media['endDate']['year']}-${media['endDate']['month']}-${media['endDate']['day']}',
          episodes: media['episodes'],
          duration: media['duration'],
          status: media['status'],
          genres: List<String>.from(media['genres']),
          averageScore: media['averageScore'].toDouble(),
          coverImage: media['coverImage']['large'],
          characters: characters,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (anime == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(anime.title)),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Image.network(anime.coverImage),
              SizedBox(height: 5.0),
              Text(
                'Informacion:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text('Start Date: ${anime.startDate}'),
              Text('End Date: ${anime.endDate}'),
              Text('Episodes: ${anime.episodes}'),
              Text('Duration: ${anime.duration} minutes'),
              Text('Status: ${anime.status}'),
              Text('Genres: ${anime.genres.join(", ")}'),
              Text('Average Score: ${anime.averageScore}'),
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
                        if (character.gender != null)
                          Text('Gender: ${character.gender}'),
                        if (character.dateOfBirth != null)
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
}
