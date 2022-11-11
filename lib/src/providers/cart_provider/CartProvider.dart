import 'package:flutter/material.dart';
import 'package:project1/src/ui/cart/components/CartItem.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  static final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem({
    required String productId,
    title,
    amount,
    price,
    image,
    type,
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => CartItem(
                productId: productId,
                id: value.id,
                title: value.title,
                amount: value.amount + 1,
                price: value.price,
                image: value.image,
                type: value.type,
              ));
      notifyListeners();
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                productId: productId,
                id: DateTime.now().toString(),
                title: title.toString(),
                amount: amount,
                price: price.toString(),
                image: image.toString(),
                type: type.toString(),
              ));
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
