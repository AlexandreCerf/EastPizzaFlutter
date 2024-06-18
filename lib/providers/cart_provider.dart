import 'package:flutter/material.dart';
import 'package:easypizza/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem({required this.pizza, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.pizza.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Pizza pizza) {
    if (_items.containsKey(pizza.id)) {
      _items[pizza.id]!.quantity++;
    } else {
      _items[pizza.id] = CartItem(pizza: pizza);
    }
    notifyListeners();
  }

  void removeItem(String pizzaId) {
    _items.remove(pizzaId);
    notifyListeners();
  }

  void updateQuantity(String pizzaId, int quantity) {
    if (_items.containsKey(pizzaId)) {
      if (quantity <= 0) {
        _items.remove(pizzaId);
      } else {
        _items[pizzaId]!.quantity = quantity;
      }
      notifyListeners();
    }
  }
}
