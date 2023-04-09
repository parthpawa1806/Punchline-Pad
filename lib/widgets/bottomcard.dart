import 'package:flutter/material.dart';
import 'dart:math';
import '../boxes/boxes.dart';
import '../models/datamodel.dart';


  Color _generateRandomPastelColor() {
    Random random = new Random();
    int r = 255 - random.nextInt(100);
    int g = 255 - random.nextInt(100);
    int b = 255 - random.nextInt(100);
    return Color.fromARGB(255, r, g, b);
  }


Widget _buildCard(int index) {
  final box = Boxes.getData();
  var data = box.values.toList().cast<BitsModels>();
  var killTimes = data[index].kill_times;
  var bombTimes = data[index].bomb_times;

  return Card(
    color: _generateRandomPastelColor(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: SizedBox(
      width: 300,
      height: 100,
      child: Text('Kill times: $killTimes, Bomb times: $bombTimes'),
    ),
  );
}
