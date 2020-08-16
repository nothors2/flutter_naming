import 'package:english_words/english_words.dart';
import 'dart:async';

class Bloc {
  Set<WordPair> saved = Set<WordPair>();
  final _savedController = StreamController<Set<WordPair>>.broadcast();
  //Stream<Set<WordPair>> getSavedSream() {
  get savedSream => _savedController.stream;
  get addCurrentSaved => _savedController.sink.add(saved);

  addToOrRemmoveFromSavedList(WordPair pair) {
    if (saved.contains(pair))
      saved.remove(pair);
    else
      saved.add(pair);
    _savedController.sink.add(saved);
  }

  dispose() {
    _savedController.close();
  }
}

var bloc = Bloc();
