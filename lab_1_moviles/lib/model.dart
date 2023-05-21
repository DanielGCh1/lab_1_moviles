import 'package:flutter/material.dart';

class Character{
  int id;
  String image;
  String fullName;
  String description;
  Color color;

  Character(this.id,this.image,this.fullName,this.description,this.color);

  factory Character.toObject(Map<String, dynamic> json, Color color) =>
    Character(
      json['character']['id'],
      json['character']['image']['large'], 
      json['character']['name']['full'], 
      json['character']['description'], 
      color,
    );

}