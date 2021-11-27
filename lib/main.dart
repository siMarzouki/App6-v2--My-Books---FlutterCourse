import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/books_list.dart';
import 'models/book.dart';
import './widgets/chart.dart';
import 'models/genres.dart';
import 'seeds/seeds.dart';
import './widgets/appbar.dart';
import './widgets/navigation-bar-items.dart';

List<Book> books = [];
void main() {
  books.addAll(booksList);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Books',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Book> _bookstoShow() {
    List<Book> selectedBooks = [];

    if (_selectedIndex == 0) {
      //all
      return books;
    } else if (_selectedIndex == 1) {
      //in progress
      for (Book b in books) {
        if (b.pagesRead != 0 && b.pagesRead != b.pages) selectedBooks.add(b);
      }
      return selectedBooks;
    } else if (_selectedIndex == 2) {
      //unstarted
      for (Book b in books) {
        if (b.pagesRead == 0) selectedBooks.add(b);
      }
      return selectedBooks;
    } else {
      //finished
      for (Book b in books) {
        if (b.pagesRead == b.pages) selectedBooks.add(b);
      }
      return selectedBooks;
    }
  }

  void _addNewBook(String title, String author, int pages, Genres genre) {
    final newBook = Book(
        id: DateTime.now().toString(),
        title: title,
        author: author,
        pages: pages,
        genre: genre);
    setState(() {
      books.add(newBook);
    });
  }

  void _updateBook(String id, int readPages) {
    setState(() {
      books.where((element) => element.id == id).first.pagesRead = readPages;
    });
  }

  void _deleteBook(String id) {
    setState(() {
      books.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    return Scaffold(
      appBar: platform == TargetPlatform.iOS
          ? iosAppBar(context, _addNewBook)
          : androidAppBar(context, _addNewBook),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Chart(books),
          BooksList(_bookstoShow(), _updateBook, _deleteBook)
        ],
      ),
      bottomNavigationBar: platform == TargetPlatform.iOS
          ? CupertinoTabBar(
              backgroundColor:
                  bottomNavigationBarItems[_selectedIndex].backgroundColor,
              inactiveColor: Colors.white,
              activeColor: Colors.yellow,
              currentIndex: _selectedIndex,
              onTap: (val) {
                setState(() {
                  _selectedIndex = val;
                });
              },
              items: bottomNavigationBarItems)
          : BottomNavigationBar(
              onTap: (val) {
                setState(() {
                  _selectedIndex = val;
                });
              },
              currentIndex: _selectedIndex,
              items: bottomNavigationBarItems),
    );
  }
}
