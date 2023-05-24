import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> sendGraphQLRequest(String query) async {
  final response = await http.post(
    Uri.parse('https://graphql.anilist.co/'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'query': query}),
  );
  return response;
}
