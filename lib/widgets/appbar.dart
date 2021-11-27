// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './new_book.dart';

//AppBar for Android
AppBar androidAppBar(BuildContext context, Function addNewBook) {
  return AppBar(
    title: const Text(
      "My Books",
      style: TextStyle(color: Colors.white),
    ),
    actions: [
      IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return NewBook(addNewBook);
              },
            );
          },
          icon: Image.asset("assets/photos/add.gif"))
    ],
  );
}

//AppBar for iOS
PreferredSizeWidget iosAppBar(BuildContext context, Function addNewBook) {
  return CupertinoNavigationBar(
    middle: const Text(
      "My Books",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.brown,
    trailing: IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return NewBook(addNewBook);
            },
          );
        },
        icon: Image.asset("assets/photos/add.gif")),
  );
}
