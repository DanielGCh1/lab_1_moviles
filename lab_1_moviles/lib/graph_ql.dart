import 'package:graphql/client.dart';

class GraphQL {
  final String baseURL;

  GraphQL(this.baseURL);

  GraphQLClient getClient() {
    final Link link = HttpLink(baseURL);

    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}

extension Graph on GraphQLClient {
  Future<dynamic> queryCharacter(String query) async {
    const String readCharacter = r'''
      query ReadCharacter($character: String) {
        character(search: $character) {
          id
          name {
            full
            native
          }
          image {
            large
          }
        }
      }
    ''';

    final WatchQueryOptions options = WatchQueryOptions(
      document: gql(readCharacter),
      variables: <String, dynamic>{'character': query},
    );

    final QueryResult result = await this.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    return result.data;
  }
}
