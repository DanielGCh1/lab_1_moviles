import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Character {
  final String name;
  final String photoUrl;

  Character({required this.name, required this.photoUrl});
}

class CharacterListWidget extends StatefulWidget {
  final String animeTitle;

  CharacterListWidget({required this.animeTitle});

  @override
  _CharacterListWidgetState createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<CharacterListWidget> {
  List<Character> characterList = [];

  @override
  void initState() {
    super.initState();
    fetchCharacterList();
  }

  Future<void> fetchCharacterList() async {
    final query = '''
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

    final variables = {
      'animeTitle': widget.animeTitle,
    };

    final response = await http.post(
      Uri.parse('https://graphql.anilist.co/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'query': query, 'variables': variables}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final characterNodes = data['data']['Media']['characters']['nodes'];

      final List<Character> characters = [];

      for (final characterNode in characterNodes) {
        final String name = characterNode['name']['full'];
        final String photoUrl = characterNode['image']['large'];

        characters.add(Character(
          name: name,
          photoUrl: photoUrl,
        ));
      }

      setState(() {
        characterList = characters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (characterList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Personajes de ${widget.animeTitle}'),
        ),
        body: ListView.builder(
          itemCount: characterList.length,
          itemBuilder: (context, index) {
            final character = characterList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(character.photoUrl),
              ),
              title: Text(character.name),
            );
          },
        ),
      );
    }
  }
}
