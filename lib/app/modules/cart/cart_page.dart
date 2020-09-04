import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/shared/models/product_model.dart';
import 'cart_controller.dart';

class CartPage extends StatefulWidget {
  final String title;
  const CartPage({Key key, this.title = "Cart"}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CartController> {
  CartController _cart = Modular.get<CartController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        var _list = _cart.cart;

        if (_list.length == 0) {
          return Center(child: Text('Seu carrinho está vazio'));
        }

        return ListView.builder(
          itemCount: _list.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => _buildCard(_list[index], index),
        );
      },
    );
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
        onTap: () => Modular.to.pushNamed('/product', arguments: product),
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
      onPressed: () => _cart.removeProduct(index),
    );
  }
}
