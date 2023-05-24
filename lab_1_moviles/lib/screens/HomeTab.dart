import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Que bien verte de nuevo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Image.asset(
          'assets/images/anime.png',
          width: 200,
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            'Laboratorio #1 Moviles \nEstudiantes: \nLibny, Daniel, Natalia y Diego',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
