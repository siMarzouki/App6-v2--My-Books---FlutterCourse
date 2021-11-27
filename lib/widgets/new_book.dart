import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../models/genres.dart';

class NewBook extends StatefulWidget {
  final Function addBook;

  const NewBook(this.addBook, {Key? key}) : super(key: key);

  @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _pagesController;
  Genres _selectedGenre = Genres.fantasy;

  @override
  void initState() {
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _pagesController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pagesController.dispose();
    super.dispose();
  }

  void _saveBook() {
    //checking data validity
    if (_titleController.text.isEmpty ||
        _authorController.text.isEmpty ||
        int.parse(_pagesController.text) <= 0) {
      return;
    }
    widget.addBook(_titleController.text, _authorController.text,
        int.parse(_pagesController.text), _selectedGenre);

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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: CupertinoTextField(
                      placeholder: "Title",
                      controller: _titleController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: CupertinoTextField(
                      placeholder: "Author",
                      controller: _authorController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: CupertinoTextField(
                      placeholder: 'Pages',
                      controller: _pagesController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Genre",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0x99000000),
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        width: 200,
                        height: 80,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: CupertinoPicker(
                          onSelectedItemChanged: (int x) {},
                          itemExtent: 30,
                          children: [
                            for (var g in Genres.values)
                              Text(g.toString().split(".").last)
                          ],
                        ),
                      ),
                    ],
                  ),
                  CupertinoButton(
                    child: const Text(
                      'Add Book',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.lightBlue,
                    onPressed: _saveBook,
                  ),
                ]
              : [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Author'),
                    controller: _authorController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Pages'),
                    controller: _pagesController,
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Genre",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0x99000000),
                            fontWeight: FontWeight.w400),
                      ),
                      DropdownButton(
                        value: _selectedGenre,
                        icon: const Icon(Icons.arrow_downward),
                        onChanged: (Genres? g) {
                          setState(() {
                            _selectedGenre = g!;
                          });
                        },
                        items: Genres.values
                            .map<DropdownMenuItem<Genres>>((Genres g) {
                          return DropdownMenuItem<Genres>(
                            value: g,
                            child: Text(g.toString().split(".").last),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextButton(
                    child: const Text('Add Book'),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        primary: Colors.white),
                    onPressed: _saveBook,
                  ),
                ],
        ),
      ),
    );
  }
}
