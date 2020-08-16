import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'saved.dart';

class Randomlist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RandomListState();
  }
}

class _RandomListState extends State<Randomlist> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    //final randomword = WordPair.random();
    return Scaffold(
        appBar: AppBar(
          title: Text("Naming App"),
          actions: [
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SavedList(
                            saved: _saved,
                          )));
                })
          ],
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index.isOdd) {
        return Divider();
      } else {
        var realIndex = index ~/ 2;
        if (realIndex >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[realIndex]);
      }
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onTap: () {
        setState(() {
          print(_suggestions.length);
          if (alreadySaved)
            _saved.remove(pair);
          else
            _saved.add(pair);

          print(_saved);
        });
      },
    );
  }
}
