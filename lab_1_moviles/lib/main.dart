import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:lab_1_moviles/graph_ql.dart';
import 'package:lab_1_moviles/model.dart';
import 'package:lab_1_moviles/util.dart';
import 'package:graphql/client.dart';

void main() => runApp(GraphQLApp());

class GraphQLApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQL',
      home: MainScreen(),
=======
import 'package:lab_1_moviles/your_anime_details_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laboratorio #1',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.blueGrey, // Fondo púrpura
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false, // Oculta el banner de "debug"
>>>>>>> Stashed changes
    );
  }
}

<<<<<<< Updated upstream
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = TextEditingController();
  final _loading = ValueNotifier(false);

  final _characters = <Character>[];

  late GraphQLClient _client;

  void handleResult(QueryResult result) {
    print(result.data);
    if (result.data != null) {
      _characters.add(Character.toObject(result.data?['character'], Utils.randomColor()));

    }
    _loading.value = false;
  }

  @override
  void initState() {
    super.initState();
    _client = GraphQL('https://graphql.anilist.co').getClient();
  }

  @override
  void dispose() {
    _controller.dispose();
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.1,
              right: size.width * 0.1,
              top: 30,
            ),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  onFieldSubmitted: (query) async {
                    _loading.value = true;
                    _controller.clear();
                    handleResult(await _client.queryCharacter(query));
                  },
                  controller: _controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Anime Characters'),
                ),
              ),
=======
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedAnime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laboratorio #1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedAnime,
              hint: Text('Seleccione un anime'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedAnime = newValue;
                });
              },
              items: <String>[
                'Attack on Titan',
                'Your Name',
                'One Piece',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedAnime != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeDetailsWidget(
                        animeTitle: selectedAnime!,
                      ),
                    ),
                  );
                }
              },
              child: Text('Ver detalles del anime seleccionado'),
>>>>>>> Stashed changes
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _loading,
              builder: (context, value, child) {
                return Stack(
                  children: [
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 30,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final character = _characters[index];
                        return Card(
                          elevation: 15,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(character.image, fit: BoxFit.cover),
                              Column(
                                children: [
                                  Expanded(child: SizedBox()),
                                  Container(
                                    width: size.width,
                                    color: character.color,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Center(
                                        child: Text(
                                          character.fullName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: _characters.length,
                    ),
                    if (value) Center(child: CircularProgressIndicator())
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
