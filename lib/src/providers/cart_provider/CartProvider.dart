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
    productTypeId,
    title,
    amount,
    price,
    image,
    type,
  }) {

    void _addNoneExistProduct(_items) {
      _items.putIfAbsent(
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
    void _addNoneExistedProductType(_items) {
      _items.putIfAbsent(
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
    void _updateExistedProductType(_items) {
      _items.update(
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

    void _updateFirstExistedProduct(_items) {
      _items.update(
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
      if(items[productId]!.productTypeId == productTypeId) {
        _updateFirstExistedProduct(_items);
        notifyListeners();
      } else {
        if(_items.containsKey('${productId}_${productTypeId}')) {
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

  List generalItems () {
    List data = [];
    Map dataItem = {};
    for(int i = 0; i < this.items.length; i++) {
      dataItem['item_id'] = this.items.values.toList()[i].productId.toString();
      dataItem['product_type_id'] = this.items.values.toList()[i].productTypeId.toString();
      dataItem['price'] = this.items.values.toList()[i].price.toString();
      dataItem['quantity'] = this.items.values.toList()[i].amount.toString();
      data.add(dataItem);
    }
    return data;
  }
}
