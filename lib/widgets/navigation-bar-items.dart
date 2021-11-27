// ignore_for_file: file_names

import 'package:flutter/material.dart';

var bottomNavigationBarItems = [
  BottomNavigationBarItem(
    icon: Image.asset(
      "assets/photos/all.png",
      height: 20,
      color: Colors.white,
    ),
    label: 'All',
    backgroundColor: Colors.brown,
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      "assets/photos/progress.png",
      height: 20,
      color: Colors.white,
    ),
    label: 'in Progress',
    backgroundColor: Colors.green,
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      "assets/photos/unstarted.png",
      height: 20,
      color: Colors.white,
    ),
    label: 'Unstarted',
    backgroundColor: Colors.purple,
  ),
  BottomNavigationBarItem(
    icon: Image.asset(
      "assets/photos/finished.png",
      height: 20,
      color: Colors.white,
    ),
    label: 'Finished',
    backgroundColor: Colors.pink,
  ),
];
