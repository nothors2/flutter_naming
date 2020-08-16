import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_naming/src/bloc/bloc.dart';
import 'saved.dart';

class Randomlist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RandomListState();
  }
}

class _RandomListState extends State<Randomlist> {
  final List<WordPair> _suggestions = <WordPair>[];
  //final Set<WordPair> _saved = Set<WordPair>();

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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SavedList()));
                })
          ],
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedSream,
        builder: (context, snapshot) {
          return ListView.builder(itemBuilder: (context, index) {
            if (index.isOdd) {
              return Divider();
            } else {
              var realIndex = index ~/ 2;
              if (realIndex >= _suggestions.length) {
                _suggestions.addAll(generateWordPairs().take(10));
              }
              return _buildRow(snapshot.data, _suggestions[realIndex]);
            }
          });
        });
  }

  Widget _buildRow(Set<WordPair> saved, WordPair pair) {
    bool alreadySaved = false;
    if (saved != null) alreadySaved = saved.contains(pair);

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
        bloc.addToOrRemmoveFromSavedList(pair);
        // setState(() {
        //   print(_suggestions.length);
        //   if (alreadySaved)
        //     bloc.saved.remove(pair);
        //   else
        //     bloc.saved.add(pair);

        //   print(bloc.saved);
        // });
      },
    );
  }
}
