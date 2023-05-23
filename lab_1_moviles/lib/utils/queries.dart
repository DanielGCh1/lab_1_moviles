import 'package:http/http.dart' as http;
import 'dart:convert';

String fetchAnimeListQuery(String? selectedGenre) => '''
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

String fetchAnimeDetailsQuery(String? title) => '''
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
        characters(perPage: 3) {
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

String fetchCharacterList(String? animeTitle) => '''
query($animeTitle: String!) {
        Media(search: \$animeTitle, type: ANIME) {
          characters {
            nodes {
              name {
                full
              }
              image {
                large
              }
            }
          }
        }
      }
''';

Future<List<String>> fetchGenreCollection() async {
  final query = '''
  query {
    GenreCollection
  }
  ''';

  List<String> listGenres = [];

  final response = await http.post(
    Uri.parse('https://graphql.anilist.co/'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'query': query}),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    listGenres =
        (data['data']['GenreCollection'] as List<dynamic>).cast<String>();
  }

  return listGenres;
}

Future<List<String>> getListAnimesQuery() async {
  final query = '''
    query {
      Page(page: 1, perPage: 30) {
        media(type: ANIME) {
          title {
            romaji
          }
        }
      }
    }
  ''';

  List<String> listAnimes = [];

  final response = await http.post(
    Uri.parse('https://graphql.anilist.co/'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'query': query}),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final mediaList = data['data']['Page']['media'] as List<dynamic>;
    listAnimes =
        mediaList.map((media) => media['title']['romaji'].toString()).toList();
  }

  return listAnimes;
}
