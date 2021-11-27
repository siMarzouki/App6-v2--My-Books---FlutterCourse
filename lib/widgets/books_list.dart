import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';
import './edit_book.dart';

class BooksList extends StatefulWidget {
  final List<Book> books;
  final Function updateBook;
  final Function deleteBook;
  const BooksList(this.books, this.updateBook, this.deleteBook, {Key? key})
      : super(key: key);

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: widget.books.isEmpty
          ? Center(
              child: Column(
                children: [
                  const Text(
                    "No Books Available !",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    "assets/photos/book.gif",
                    height: 250,
                  )
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    elevation: 8,
                    margin: const EdgeInsets.all(7),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                Colors.accents[index % Colors.accents.length],
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: FittedBox(
                                child: Text(
                                  widget.books[index].genre
                                      .toString()
                                      .split(".")
                                      .last
                                      .toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            widget.books[index].title,
                          ),
                          subtitle: Text(widget.books[index].author),
                          trailing: FittedBox(
                            fit: BoxFit.cover,
                            child: Row(
                              children: [
                                Text(
                                    "${widget.books[index].pagesRead} / ${widget.books[index].pages}"),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (_) {
                                            return EditBook(
                                                widget.books[index],
                                                widget.updateBook,
                                                widget.deleteBook);
                                          });
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.accents[
                                          index % Colors.accents.length],
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: widget.books[index].pagesRead,
                              child: Container(
                                color: Colors.green,
                                height: 4,
                              ),
                            ),
                            Flexible(
                              flex: widget.books[index].pages -
                                  widget.books[index].pagesRead,
                              child: Container(
                                color: Colors.grey,
                                height: 4,
                              ),
                            ),
                          ],
                        )
                      ],
                    ));
              },
              itemCount: widget.books.length,
            ),
    );
  }
}
