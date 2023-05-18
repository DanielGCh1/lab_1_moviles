import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class YourName {
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final int episodes;
  final int duration;
  final String status;
  final List<String> genres;
  final double averageScore;
  final String coverImage;

  YourName({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.episodes,
    required this.duration,
    required this.status,
    required this.genres,
    required this.averageScore,
    required this.coverImage,
  });
}

class YourNameWidget extends StatefulWidget {
  @override
  _YourNameWidgetState createState() => _YourNameWidgetState();
}

class _YourNameWidgetState extends State<YourNameWidget> {
  late YourName yourName;

  @override
  void initState() {
    super.initState();
    fetchYourName();
  }

  Future<void> fetchYourName() async {
    final query = '''
    query {
      Media(search: "Your Name", type: ANIME) {
        title {
          romaji
          english
          native
        }
        description
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

      setState(() {
        yourName = YourName(
          title: media['title']['romaji'],
          description: media['description'],
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
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (yourName == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(yourName.title)),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Image.network(yourName.coverImage),
              SizedBox(height: 16.0),
              Text(
                'Description: ${yourName.description}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('Start Date: ${yourName.startDate}'),
              Text('End Date: ${yourName.endDate}'),
              Text('Episodes: ${yourName.episodes}'),
              Text('Duration: ${yourName.duration} minutes'),
              Text('Status: ${yourName.status}'),
              Text('Genres: ${yourName.genres.join(", ")}'),
              Text('Average Score: ${yourName.averageScore}'),
            ],
          ),
        ),
      );
    }
  }
}
