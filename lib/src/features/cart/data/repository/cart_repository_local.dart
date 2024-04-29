import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:pharmacy_hub/src/features/cart/data/models/cart_model.dart';

const String cartBoxName = 'cart';

abstract class CartLocalRepository {
  Future<List<CartItem>> getCarts();

  Future<int> addCart(CartItem item);

  Future<void> removeAllCart();

  Future<void> removeCartItem(int id);

  Future<bool> isItemAdded(int id);

  Future<CartItem> getCartItem(int id);

  Future<void> updateCartItem(CartItem item);

  Future<Iterable<int>> addAllCart(List<CartItem> items);

  Future<double> getTotalPrice();
}

class CartLocalRepositoryImpl extends CartLocalRepository {
  final Box _box = Hive.box(cartBoxName);

  @override
  Future<int> addCart(CartItem item) async {
    return await _box.add(item);
  }

  @override
  Future<Iterable<int>> addAllCart(List<CartItem> items) async {
    return await _box.addAll(items);
  }

  @override
  Future<List<CartItem>> getCarts() async {
    return _box.values.map((e) => CartItem.fromEntity(e)).toList();
  }

  @override
  Future<bool> isItemAdded(int id) async {
    return (_box.values.toList().indexWhere((e) => e.id == id)) == -1
        ? false
        : true;
  }

  @override
  Future<void> removeAllCart() async {
    await _box.clear();
  }

  @override
  Future<void> removeCartItem(int id) async {
    // Find the key for the item with the matching id
    var keyToDelete = _box.keys.firstWhere(
      (k) => _box.get(k).id == id,
      orElse: () => null,
    );

    // If a key was found, delete the item from the box
    if (keyToDelete != null) {
      await _box.delete(keyToDelete);
    }
  }

  @override
  Future<CartItem> getCartItem(int id) async {
    return _box.values.firstWhere(
      (item) => item.id == id,
      orElse: () => null,
    );
  }

  @override
  Future<void> updateCartItem(CartItem item) async {
    // Find the key for the item with the matching id
    var updateKey = _box.keys.firstWhere(
      (k) => _box.get(k).id == item.id,
      orElse: () => null,
    );

    log("updated key $updateKey || items updated $item");

    await _box.put(updateKey, item);
  }

  @override
  Future<double> getTotalPrice() {
    double total = 0.0;
    for (CartItem item in _box.values) {
      total += item.price * item.quantity;
    }
    return Future.value(total);
  }
}
