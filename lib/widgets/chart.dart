import '../models/book.dart';
import 'package:flutter/material.dart';
import './top_genre.dart';
import '../models/genres.dart';

class Chart extends StatefulWidget {
  final List<Book> books;
  const Chart(this.books, {Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

TextStyle tStyle = const TextStyle(
    fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500);

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    int all = widget.books.length;
    int unstarted = 0;
    int finished = 0;
    int inProgress = 0;
    Map genresOcc = {};
    for (Book b in widget.books) {
      if (genresOcc.containsKey(b.genre)) {
        genresOcc[b.genre] += 1;
      } else {
        genresOcc[b.genre] = 1;
      }
      if (b.pagesRead == 0) {
        unstarted++;
      } else if (b.pages == b.pagesRead) {
        finished++;
      } else {
        inProgress++;
      }
    }
    List values = genresOcc.values.toList();
    values.sort();
    values = values.reversed.toList();
    var popularGenres = [];
    //top genres [0,3]
    int min = values.length < 3 ? values.length : 3;
    for (int i = 0; i < min; i++) {
      for (Genres x in Genres.values) {
        if (genresOcc[x] == values[i]) {
          //remove the enum notation
          //example
          //Genres.fantasy => "fantasy"
          popularGenres.add(x.toString().split(".").last);
          genresOcc.remove(x);
          break;
        }
      }
    }
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.brown, borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(width: 80, child: Text("All", style: tStyle)),
                      Container(
                        width: 130,
                        height: 8,
                        margin: const EdgeInsets.only(right: 10),
                        color: Colors.lightBlue,
                      ),
                      Text(all.toString(), style: tStyle)
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 80, child: Text("Finished", style: tStyle)),
                      Container(
                        width: all == 0 ? 0 : 130 * (finished / all),
                        margin: EdgeInsets.only(
                            right: all == 0
                                ? 160
                                : 130 * (1 - (finished / all)) + 10),
                        height: 8,
                        color: Colors.green,
                      ),
                      Text(finished.toString(), style: tStyle)
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 80, child: Text("In Progress", style: tStyle)),
                      Container(
                        width: all == 0 ? 0 : 130 * (inProgress / all),
                        margin: EdgeInsets.only(
                            right: all == 0
                                ? 160
                                : 130 * (1 - (inProgress / all)) + 10),
                        height: 8,
                        color: Colors.purple,
                      ),
                      Text(inProgress.toString(), style: tStyle)
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 80, child: Text("Unstarted", style: tStyle)),
                      Container(
                        width: all == 0 ? 0 : 130 * (unstarted / all),
                        margin: EdgeInsets.only(
                            right: all == 0
                                ? 160
                                : 130 * (1 - (unstarted / all)) + 10),
                        height: 8,
                        color: Colors.pink,
                      ),
                      Text(unstarted.toString(), style: tStyle)
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.brown, borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text("Top Genres", style: tStyle),
                popularGenres.isNotEmpty
                    ? TopGenre(1, popularGenres[0])
                    : Container(),
                popularGenres.length > 1
                    ? TopGenre(2, popularGenres[1])
                    : Container(),
                popularGenres.length > 2
                    ? TopGenre(3, popularGenres[2])
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
