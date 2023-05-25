import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¡Bienvenidos!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontFamily: 'Great Vibes',
            color: Color.fromARGB(255, 11, 114, 128),
          ),
        ),
        SizedBox(height: 16),
        Image.asset(
          'assets/images/anime.png',
          width: 200,
        ),
        SizedBox(height: 16),
        Column(children: [
          Text(
            'Laboratorio 1 Moviles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(255, 11, 114, 128),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Estudiantes:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'Great Vibes',
              decoration: TextDecoration.underline,
              color: Color.fromRGBO(213, 153, 12, 1),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Daniel Gómez \n Natalia Rojas \n Diego Jiménez  \n Libny Gómez',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Times New Roman',
                color: Color.fromRGBO(213, 153, 12, 1)),
            textAlign: TextAlign.center,
          ),
        ]),
      ],
    );
  }
}
