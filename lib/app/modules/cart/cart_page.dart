import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/product/product_page_params.dart';
import 'package:siclos/app/modules/wallet/wallet_controller.dart';
import 'package:siclos/app/shared/models/product_model.dart';
import 'cart_controller.dart';

class CartPage extends StatefulWidget {
  final String title;
  const CartPage({Key key, this.title = "Cart"}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CartController> {
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

  Widget _buildCard(ProductModel product, int index) {
    return Card(
      elevation: 1,
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        leading: _buildImage(product.image, product.id),
        title: _buildTitle(product.name, product.id),
        subtitle: _buildSubTitle(product.price),
        trailing: _buildDeleteAction(index),
        onTap: () => Modular.to.pushNamed('/product', arguments: ProductPageParams(productModel: product, isCart: true)),
      ),
    ); //
  }

  Widget _buildImage(String uriFile, int id) {
    return Hero(
      tag: 'product_cart_$id',
      child: Image.network(
        uriFile,
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _buildTitle(String title, int id) {
    return Text(title);
  }

  Widget _buildSubTitle(double price) {
    return Text(price.toStringAsFixed(2));
  }

  IconButton _buildDeleteAction(int index) {
    return IconButton(
      icon: Icon(
        Icons.delete_forever,
        color: Colors.red,
      ),
      onPressed: () => controller.removeFromPosition(index),
    );
  }

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
