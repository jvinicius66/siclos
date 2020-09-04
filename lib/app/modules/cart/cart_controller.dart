import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/cart/repositories/cart_repository.dart';
import 'package:siclos/app/shared/models/product_model.dart';

part 'cart_controller.g.dart';

@Injectable()
class CartController = _CartControllerBase with _$CartController;

abstract class _CartControllerBase with Store {
  final CartRepository repository;

  _CartControllerBase(this.repository) {
    fetchCart();
  }

  @observable
  ObservableList<ProductModel> cart = ObservableList<ProductModel>.of([]);

  @action
  fetchCart() {
    cart.clear();
    repository.fetchCart().then((value) => cart.addAll(value));
  }

  @action
  void addProduct(ProductModel product) {
    cart.add(product);
    repository.save(cart);
  }

  @action
  void removeFromPosition(int position) {
    cart.removeAt(position);
    repository.save(cart);
  }

  @action
  void removeFromProduct(ProductModel product) {
    cart.removeWhere((item) => item.hashCode == product.hashCode);
    repository.save(cart);
  }

  @action
  void clear() {
    cart.clear();
    repository.save(cart);
  }

  @action
  double getTotal() {
    double _total = 0;
    cart.forEach((ProductModel product) => _total += product.price);
    return _total;
  }
}
