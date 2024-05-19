import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_project/Model/cartModel.dart';
import 'package:shopping_project/dbhelper.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  int _counter = 0;
  double _totalPrice = 0.0;
  List<Cart> cart = [];

  int getCounter() => _counter;
  double getTotalPrice() => _totalPrice;

  Future<void> _getSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_counter') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  Future<void> _saveSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_counter', _counter);
    prefs.setDouble('total_price', _totalPrice);
  }

  void addCounter() {
    _counter++;
    _saveSharedPrefs();
    notifyListeners();
  }

  void removeCounter() {
    if (_counter > 0) {
      _counter--;
    } else {
      _counter = 0;
    }
    _saveSharedPrefs();
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice += productPrice;
    _saveSharedPrefs();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice -= productPrice;
    _saveSharedPrefs();
    notifyListeners();
  }

  void resetCart() {
    _counter = 0;
    _totalPrice = 0.0;
    _saveSharedPrefs();
    notifyListeners();
  }

  Future<List<Cart>> getData() async {
    cart = await db.getCartList();
    _getSharedPrefs();
    return cart;
  }
}
