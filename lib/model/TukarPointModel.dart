import 'package:flutter/material.dart';

class TukarPointModel {
  String name;
  String image;
  double rating;
  String price;
  String brand;
  String description;
  int quantity = 0;

  TukarPointModel(
      {this.name,
      this.image,
      this.brand,
      this.price,
      this.rating,
      this.description,
      this.quantity});

  
}


