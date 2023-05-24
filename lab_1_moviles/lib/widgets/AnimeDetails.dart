import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab_1_moviles/utils/queries.dart';

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

class AnimeDetails extends StatefulWidget {
  final String animeTitle;

  AnimeDetails({required this.animeTitle});

  @override
  _AnimeDetailsWidgetState createState() => _AnimeDetailsWidgetState();
}

class _AnimeDetailsWidgetState extends State<AnimeDetails> {
  late Anime anime = Anime(
      title: '',
      startDate: '',
      endDate: '',
      episodes: 0,
      duration: 0,
      status: '',
      genres: [],
      averageScore: 0,
      coverImage: '',
      characters: []);

  @override
  void initState() {
    fetchAnimeDetails(widget.animeTitle);
    super.initState();
  }

  void fetchAnimeDetails(String title) {
<<<<<<< Updated upstream
    final query = fetchAnimeDetailsQuery(title);
    /*
    '''
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
    ''';*/

=======
    final query = fetchAnimeDetailsQuery(title); //query
>>>>>>> Stashed changes
    http
        .post(Uri.parse('https://graphql.anilist.co/'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'query': query}))
        .then((value) {
      if (value.statusCode == 200) {
        final data = json.decode(value.body);
        final media = data['data']['Media'];

        final List<Character> characters = [];

        // Obtener la lista de personajes
        final List<dynamic> characterEdges = media['characters']['edges'];
        for (final edge in characterEdges) {
          final character = edge['node'];
          final String? name = character['name']['full'] ?? "";
          final String? gender = character['gender'];
          final Map<String, dynamic> dateOfBirth = character['dateOfBirth'];
          final int? month = dateOfBirth['month'] ?? 0;
          final int? day = dateOfBirth['day'] ?? 0;
          final String? image = character['image']['large'] ?? "";

          characters.add(Character(
            name: name ?? "",
            gender: gender ?? 'Desconocido',
            dateOfBirth:
                month != null && day != null ? '$month-$day' : 'Desconocido',
            image: image ?? "",
          ));
        }

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
            characters: characters ?? [],
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(anime.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            (anime.coverImage.isNotEmpty)
                ? Image.network(anime.coverImage)
                : SizedBox(height: 5.0),
            SizedBox(height: 10.0),
            Text(
              'Información:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            _buildInfoRow('Fecha de inicio', anime.startDate),
            _buildInfoRow('Fecha de finalización', anime.endDate),
            _buildInfoRow('Episodios', anime.episodes.toString()),
            _buildInfoRow('Duración', '${anime.duration} minutos'),
            _buildInfoRow('Estado', anime.status),
            _buildInfoRow('Géneros', anime.genres.join(", ")),
            _buildInfoRow('Puntuación', anime.averageScore.toString()),
            SizedBox(height: 16.0),
            Text(
              'Personajes:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: anime.characters.length,
              itemBuilder: (context, index) {
                final character = anime.characters[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      child: Container(
                        width: 60,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(character.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      character.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.0),
                        if (character.gender != null)
                          Text('Gender: ${character.gender}'),
                        SizedBox(height: 2.0),
                        if (character.dateOfBirth != null)
                          Text('Date of Birth: ${character.dateOfBirth}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
