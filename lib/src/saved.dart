import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedList extends StatefulWidget {
  @override
  final Set<WordPair> saved;
  SavedList({@required this.saved});
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
    return ListView.builder(
        itemCount: widget.saved.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          } else {
            var realIndex = index ~/ 2;
            return _buildRow(widget.saved.toList()[realIndex]);
          }
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        setState(() {
          widget.saved.remove(pair);
        });
      },
    );
  }
}
