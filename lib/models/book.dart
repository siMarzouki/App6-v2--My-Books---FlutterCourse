import 'genres.dart';

//book model
//in this app the book attribues are unchangeable
class Book {
  final String id;
  final String title;
  final String author;
  final int pages;
  int pagesRead = 0;
  final Genres genre;
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.pages,
    required this.genre,
  });
}
