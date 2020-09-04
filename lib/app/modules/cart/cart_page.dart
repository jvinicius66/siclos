/*
 * cart_page.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/cart
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Page of cart
*/

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/product/product_page_params.dart';
import 'package:siclos/app/modules/wallet/wallet_controller.dart';
import 'package:siclos/app/shared/models/product_model.dart';
import 'cart_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CartController> {
  /*
  * @variable    : _walletController
  * @description : Wallet Controller to calculation of balance
  */
  final WalletController _walletController = Modular.get<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      var _list = controller.cart;

      if (_list.length == 0) {
        return Center(child: Text('Seu carrinho está vazio'));
      }

      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: _list.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => _buildCard(_list[index], index),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.lime,
                child: Text(
                  'Finalizar compra',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async => _confirmDialog(),
              ),
            ),
          ),
        ],
      );
    });
  }

  /*
  * @method         : _buildCard
  * @description    : Build card of the show product
  * @param[product] : Product to manupulation data
  * @param[index]   : Item Index to delete object
  */
  Widget _buildCard(ProductModel product, int index) {
    return Card(
      elevation: 1,
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        leading: _buildImage(product.image, product.id),
        title: _buildTitle(product.name),
        subtitle: _buildPrice(product.price),
        trailing: _buildDeleteAction(index),
        onTap: () => Modular.to.pushNamed('/product', arguments: ProductPageParams(productModel: product, isCart: true)),
      ),
    ); //
  }

  /*
  * @method         : _buildImage
  * @description    : Build image of product (cached)
  * @param[uriFile] : URI to file of the product
  * @param[id]      : Product ID to Hero animation
  */
  Widget _buildImage(String uriFile, int id) {
    return Hero(
      tag: 'product_cart_$id',
      child: ExtendedImage.network(
        uriFile,
        height: 300,
        fit: BoxFit.fill,
        cache: true,
        border: Border.all(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
    );
  }

  /*
  * @method       : _buildTitle
  * @description  : Build title of the product
  * @param[title] : Title of the product
  */
  Widget _buildTitle(String title) {
    return Text(title);
  }

  /*
  * @method       : _buildPrice
  * @description  : Build price of the product
  * @param[price] : Price of the product
  */
  Widget _buildPrice(double price) {
    return Text(price.toStringAsFixed(2));
  }

  /*
  * @method       : _buildDeleteAction
  * @description  : Build action of delete record
  * @param[index] : Index of delete in list
  */
  IconButton _buildDeleteAction(int index) {
    return IconButton(
      icon: Icon(
        Icons.delete_forever,
        color: Colors.red,
      ),
      onPressed: () => controller.removeFromPosition(index),
    );
  }

  /*
  * @method       : _confirmDialog
  * @description  : Alert of confirmation to checkout
  */
  void _confirmDialog() {
    double _totalProductsInCart = controller.getTotal();
    double _balance = _walletController.balance;
    double _difference = (_balance < 0 ? _totalProductsInCart : _totalProductsInCart - _balance);
    String _message = _difference > 0
        ? 'Você vai precisar de um empréstimo no valor de ${_difference.toStringAsFixed(2)}'
        : 'Será abatido o valor de ${_totalProductsInCart.toStringAsFixed(2)} do seu saldo de ${_balance.toStringAsFixed(2)}';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Finalizar compra'),
          content: new Text('$_message\n\nConfirma a compra?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            new FlatButton(
              child: new Text("Confirmar"),
              onPressed: () async {
                await _walletController.purchase(_totalProductsInCart);
                controller.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
