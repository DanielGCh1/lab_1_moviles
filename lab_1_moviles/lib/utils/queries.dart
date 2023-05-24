import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> fetchGenreCollection() async {
  final query = '''
    query {
      GenreCollection
    }
  ''';

  final response = await sendGraphQLRequest(query);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> genreList = data['data']['GenreCollection'];
    final List<String> listGenres = genreList.cast<String>().toList();
    return listGenres;
  } else {
    return [];
  }
}

Future<List<String>> getListAnimesQuery() async {
  final query = '''
    query {
      Page(page: 1, perPage: 30) {
        media(type: ANIME, sort: POPULARITY_DESC) {
          title {
            romaji
          }
        }
      }
    }
  ''';

  final response = await sendGraphQLRequest(query);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> mediaList = data['data']['Page']['media'];
    final List<String> listAnimes =
        mediaList.map((media) => media['title']['romaji'].toString()).toList();
    return listAnimes;
  } else {
    return [];
  }
}

Future<http.Response> sendGraphQLRequest(String query) async {
  final response = await http.post(
    Uri.parse('https://graphql.anilist.co/'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'query': query}),
  );
  return response;
}

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

String fetchCharacterListQuery(String? animeTitle) => '''
  query(\$animeTitle: String!) {
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
