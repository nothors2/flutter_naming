import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'bloc/bloc.dart';

class SavedList extends StatefulWidget {
  @override
  //SavedList({@required this.saved});
  _SavedList createState() => _SavedList();
}

class _SavedList extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
        actions: [],
      ),
      body: _buildList(), //Text(saved.toString()),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedSream,
        builder: (context, snapshot) {
          // var saved = Set<WordPair>();
          // if (snapshot.hasData)
          //   saved.addAll(snapshot.data);
          // else
          //   bloc.addCurrentSaved;

          bloc.addCurrentSaved;
          var saved = snapshot.hasData ? snapshot.data : Set<WordPair>();

          return ListView.builder(
              itemCount: saved.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return Divider();
                } else {
                  var realIndex = index ~/ 2;
                  return _buildRow(saved.toList()[realIndex]);
                }
              });
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        bloc.addToOrRemmoveFromSavedList(pair);
        // setState(() {
        //   widget.saved.remove(pair);
        // });
      },
    );
  }
}
