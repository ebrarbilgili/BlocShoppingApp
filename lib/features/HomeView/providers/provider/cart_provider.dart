import 'package:flutter/material.dart';

import '../../model/home_model.dart';

class CartProvider extends ChangeNotifier {
  Map<HomeModel, int> cart = {};

  void addFirstItemToBasket(HomeModel model) {
    cart[model] = 1;
    notifyListeners();
  }

  void addItemToBasket(HomeModel model) {
    if (cart[model] == null) {
      addFirstItemToBasket(model);
    } else {
      cart[model] = cart[model]! + 1;
      notifyListeners();
    }
  }

  void clear(HomeModel model) {
    if (cart.containsKey(model)) {
      cart.remove(model);
      notifyListeners();
    }
  }
}
