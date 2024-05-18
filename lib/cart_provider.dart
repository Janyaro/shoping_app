import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  int _counter = 0;
  double _totalPrice = 0.0;

  int get counter => _counter;
  double get totalPrice => _totalPrice;

  Future<void> setPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter);
    prefs.setDouble('total_price', _totalPrice);
  }

  Future<void> getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    setPreference();
    notifyListeners();
  }

  int getCounter() {
    getPreference();
    return _counter;
  }

  void removeCounter() {
    _counter--;
    setPreference();
    notifyListeners();
  }

  void addTotalPrice(double price) {
    _totalPrice += price;
    setPreference();
    notifyListeners();
  }

  void removeTotalPrice(double price) {
    _totalPrice -= price;
    setPreference();
    notifyListeners();
  }

  double getTotalPrice() {
    getPreference();
    return _totalPrice;
  }
}
