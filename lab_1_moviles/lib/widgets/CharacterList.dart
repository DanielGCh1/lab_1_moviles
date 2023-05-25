import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models.dart';
import '../utils/Queries.dart';


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
    final query = fetchCharacterListQuery(
        widget.animeTitle); // Utiliza la consulta desde queries.dart
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
            /* return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(character.photoUrl),
              ),
              title: Text(character.name),
            );*/
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
                        image: NetworkImage(character.photoUrl),
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
                    //Text(character.name),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
