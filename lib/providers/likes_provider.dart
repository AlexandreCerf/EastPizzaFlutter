import 'package:flutter/material.dart';
import 'dart:collection';

class LikesProvider with ChangeNotifier {
  final List<String> _likedPizzas = [];

  UnmodifiableListView<String> get likedPizzas => UnmodifiableListView(_likedPizzas);

  void addLike(String pizzaId) {
    if (!_likedPizzas.contains(pizzaId)) {
      _likedPizzas.add(pizzaId);
      notifyListeners();
    }
  }

  void removeLike(String pizzaId) {
    if (_likedPizzas.contains(pizzaId)) {
      _likedPizzas.remove(pizzaId);
      notifyListeners();
    }
  }

  bool isLiked(String pizzaId) {
    return _likedPizzas.contains(pizzaId);
  }
}
