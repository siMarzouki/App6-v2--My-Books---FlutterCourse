import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';

class EditBook extends StatefulWidget {
  final Book book;
  final Function updateBook;
  final Function deleteBook;
  const EditBook(this.book, this.updateBook, this.deleteBook, {Key? key})
      : super(key: key);

  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  late TextEditingController _pagesController;

  @override
  void initState() {
    _pagesController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pagesController.dispose();
    super.dispose();
  }

  void _updateBook() {
    int read = int.parse(_pagesController.text);
    //checking the validity of number
    if (read < 0 || read > widget.book.pages) {
      return;
    }
    widget.updateBook(widget.book.id, read);

    Navigator.of(context).pop();
  }

  void _deleteBook() {
    widget.deleteBook(widget.book.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: platform == TargetPlatform.iOS
              ? [
                  CupertinoTextField(
                    placeholder: 'Read Pages',
                    controller: _pagesController,
                    keyboardType: TextInputType.number,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: CupertinoButton(
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlue,
                      onPressed: _updateBook,
                    ),
                  ),
                  CupertinoButton(
                    child: const Text(
                      'Delete Book',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: _deleteBook,
                  ),
                ]
              : [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Read Pages'),
                    controller: _pagesController,
                    keyboardType: TextInputType.number,
                  ),
                  TextButton(
                    child: const Text('Update'),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        primary: Colors.white),
                    onPressed: _updateBook,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextButton(
                    child: const Text('Delete Book'),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red, primary: Colors.white),
                    onPressed: _deleteBook,
                  ),
                ],
        ),
      ),
    );
  }
}
