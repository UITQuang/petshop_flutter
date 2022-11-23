import 'package:project1/src/ui/cart/components/CartItem.dart';
import 'package:flutter/material.dart';


class CartProvider extends ChangeNotifier {
  static final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem({
    required String productId,
    productTypeId,
    title,
    amount,
    price,
    image,
    type,
  }) {
    void _addNoneExistProduct(items) {
      items.putIfAbsent(
          productId,
          () => CartItem(
                productId: productId,
                id: DateTime.now().toString(),
                productTypeId: productTypeId.toString(),
                title: title.toString(),
                amount: amount,
                price: price.toString(),
                image: image.toString(),
                type: type.toString(),
              ));
    }

    void _addNoneExistedProductType(items) {
      items.putIfAbsent(
          '${productId}_${productTypeId}',
          () => CartItem(
                productId: productId,
                id: DateTime.now().toString(),
                productTypeId: productTypeId.toString(),
                title: title.toString(),
                amount: amount,
                price: price.toString(),
                image: image.toString(),
                type: type.toString(),
              ));
    }

    void _updateExistedProductType(items) {
      items.update(
          '${productId}_${productTypeId}',
          (value) => CartItem(
                productId: productId,
                id: value.id,
                productTypeId: productTypeId,
                title: value.title,
                amount: value.amount + 1,
                price: value.price,
                image: value.image,
                type: value.type,
              ));
    }

    void _updateFirstExistedProduct(items) {
      items.update(
          productId,
          (value) => CartItem(
                productId: productId,
                id: value.id,
                productTypeId: productTypeId,
                title: value.title,
                amount: value.amount + 1,
                price: value.price,
                image: value.image,
                type: value.type,
              ));
    }

    if (_items.containsKey(productId)) {
      if (items[productId]!.productTypeId == productTypeId) {
        _updateFirstExistedProduct(_items);
        notifyListeners();
      } else {
        if (_items.containsKey('${productId}_${productTypeId}')) {
          _updateExistedProductType(_items);
          notifyListeners();
        } else {
          _addNoneExistedProductType(_items);
          notifyListeners();
        }
      }
    } else {
      _addNoneExistProduct(_items);
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  double totalProductCost() {
    double total = 0.0;
    _items.forEach((key, value) {
      total = total + double.parse(value.price) * value.amount;
    });
    return total;
  }

  double totalPay(shipCost) {
    double total = 0.0;
    _items.forEach((key, value) {
      total = total + double.parse(value.price) * value.amount;
    });
    return total + shipCost;
  }

  List generalItems() {
    List data = [];
    for (int i = 0; i < items.length; i++) {
      data.add({
        'item_id': items.values.toList()[i].productId.toString(),
        'product_type_id': items.values.toList()[i].productTypeId.toString(),
        'price': items.values.toList()[i].price.toString(),
        'quantity': items.values.toList()[i].amount.toString(),
      });
    }
    return data;
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void setCartItemAmount(id, value) {
    for (int i = 0; i < items.length; i++) {
      if(_items.values.toList()[i].id == id) {
        _items.values.toList()[i].amount = value;
      }
    }
  }
}
