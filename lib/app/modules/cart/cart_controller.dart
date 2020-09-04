/*
 * cart_controller.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/cart
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Controller of Cart
*/

import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/shared/models/product_model.dart';

import 'repositories/interfaces/cart_repository_interface.dart';

part 'cart_controller.g.dart';

@Injectable()
class CartController = _CartControllerBase with _$CartController;

abstract class _CartControllerBase with Store {
  /*
  * @variable    : repository
  * @description : repository of fetch data
  */
  final ICartRepository repository;

  /*
  * @method            : constructor
  * @param[repository] : fetch initial data
  */
  _CartControllerBase(this.repository) {
    fetchCart();
  }

  /*
  * @variable    : cart
  * @description : Empty instance of list product model
  * @result      : Empty list
  */
  @observable
  ObservableList<ProductModel> cart = ObservableList<ProductModel>.of([]);

  /*
  * @method      : fetchCart
  * @description : Clear and fetch List of Product
  */
  @action
  fetchCart() {
    cart.clear();
    repository.fetchCart().then((value) => cart.addAll(value));
  }

  /*
  * @method         : addProduct
  * @description    : Add product in list cart
  * @param[product] : Product to add in List
  */
  @action
  void addProduct(ProductModel product) {
    cart.add(product);
    repository.save(cart);
  }

  /*
  * @method          : removeFromPosition
  * @description     : remove product in list cart for position
  * @param[position] : Index of position to remove item
  */
  @action
  void removeFromPosition(int position) {
    cart.removeAt(position);
    repository.save(cart);
  }

  /*
  * @method         : removeFromProduct
  * @description    : remove product in list cart for HashCode
  * @param[product] : Product Model to remove in list
  */
  @action
  void removeFromProduct(ProductModel product) {
    cart.removeWhere((item) => item.hashCode == product.hashCode);
    repository.save(cart);
  }

  /*
  * @method         : clear
  * @description    : Clear list and save in storage
  */
  @action
  void clear() {
    cart.clear();
    repository.save(cart);
  }

  /*
  * @method         : getTotal
  * @description    : Get sum of product's price in cart
  * @result         : Valor of total
  */
  @action
  double getTotal() {
    double _total = 0;
    cart.forEach((ProductModel product) => _total += product.price);
    return _total;
  }
}
