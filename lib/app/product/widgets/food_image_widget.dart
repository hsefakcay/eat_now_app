import 'package:flutter/material.dart';

class FoodImage extends StatelessWidget {
  const FoodImage({
    super.key,
    required this.height,
    required this.name,
  });

  final double height;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
          height: height * 0.35,
          image: NetworkImage("http://kasimadalan.pe.hu/yemekler/resimler/${name}")),
    );
  }
}
