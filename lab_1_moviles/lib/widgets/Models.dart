class Character {
  final String name;
  final String photoUrl;

  Character({required this.name, required this.photoUrl});
}

class Anime {
  final String title;
  final String coverImage;
  final int episodes;
  final String status;
  final double averageScore;

  Anime({
    required this.title,
    required this.coverImage,
    required this.episodes,
    required this.status,
    required this.averageScore,
  });
}

/*
class Animed {
  final String title;
  final String startDate;
  final String endDate;
  final int episodes;
  final int duration;
  final String status;
  final List<String> genres;
  final double averageScore;
  final String coverImage;
  final List<Character> characters;

  Animed({
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

class Characterd {
  final String name;
  final String gender;
  final String dateOfBirth;
  final String image;

  Characterd({
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.image,
  });
}
*/