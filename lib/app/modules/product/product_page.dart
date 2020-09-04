/*
 * product_page.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/product
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Page of detail of Product
*/

import 'package:extended_image/extended_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/cart/cart_controller.dart';
import 'package:siclos/app/modules/home/home_controller.dart';
import 'package:siclos/app/modules/product/product_page_params.dart';
import 'package:siclos/app/shared/models/product_model.dart';
import 'product_controller.dart';

class ProductPage extends StatefulWidget {
  final ProductPageParams params;
  /*
  * @method                   : constructor
  * @param[ProductPageParams] : class of parameters
  */
  const ProductPage({Key key, @required this.params}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ModularState<ProductPage, ProductController> {
  /*
  * @variable    : _scaffoldKey
  * @description : Manipulation GlobalKey of Scaffold
  */
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  /*
  * @variable    : _product
  * @description : Manipulation product data
  */
  ProductModel _product;
  /*
  * @variable    : _isCart
  * @description : Condition if the page is called by cart
  */
  bool _isCart;

  @override
  void initState() {
    super.initState();
    _product = widget.params.productModel;
    _isCart = widget.params.isCart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Detalhes do Produto',
          style: TextStyle(
            color: Colors.green,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildImage(),
              _buildTitle(),
              _buildDescription(),
              _buildCaracteristics(),
              (!this._isCart) ? _buildButtons() : Center(),
            ],
          ),
        ),
      ),
    );
  }

  /*
  * @method      : _buildImage
  * @description : Build image of product
  */
  Widget _buildImage() {
    return Stack(
      children: [
        Hero(
          tag: (!this._isCart ? 'product_${_product.id}' : 'product_cart_${_product.id}'),
          child: Center(
            child: ExtendedImage.network(
              _product.image,
              height: 300,
              fit: BoxFit.fill,
              cache: true,
              border: Border.all(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 30,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite_outline, color: Colors.red[200]),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  /*
  * @method      : _buildTitle
  * @description : Build title of product
  */
  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Text(
        _product.name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /*
  * @method      : _buildDescription
  * @description : Build description of product
  */
  Widget _buildDescription() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        _product.description,
        textAlign: TextAlign.justify,
        style: TextStyle(
          height: 1.5,
          color: Color(0xFF6F8398),
          fontSize: 18,
        ),
      ),
    );
  }

  /*
  * @method      : _buildButtons
  * @description : Build buttons of add to cart and go to cart
  */
  Widget _buildButtons() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
              color: Colors.lime,
              child: Text(
                'Ir para compra',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                HomeController _homeController = Modular.get<HomeController>();
                Navigator.of(context).pop();
                _homeController.pageViewConroller.jumpToPage(2);
              }),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            color: Colors.green,
            child: Text(
              'Adicionar ao carrinho',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              CartController _cart = Modular.get<CartController>();
              _cart.addProduct(_product);
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                flushbarStyle: FlushbarStyle.GROUNDED,
                message: 'Produto adicionando no carrinho',
                icon: Icon(
                  Icons.add_shopping_cart,
                  size: 28.0,
                  color: Colors.green[300],
                ),
                duration: Duration(seconds: 2),
                leftBarIndicatorColor: Colors.green[300],
              )..show(context);
            },
          ),
        ),
      ],
    );
  }

  /*
  * @method      : _buildCaracteristics
  * @description : Build characteristics of products
  */
  Widget _buildCaracteristics() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Cor'),
              Row(
                children: <Widget>[
                  _circularColor(Colors.black),
                  _circularColor(Colors.red),
                  _circularColor(Colors.green),
                  _circularColor(Colors.yellow),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              Text('Preço \$'),
              Text(
                _product.price.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F2F3E),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /*
  * @method      : _circularColor
  * @description : Build widget of colors paint
  */
  Widget _circularColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 30,
      height: 30,
      margin: EdgeInsets.all(5),
    );
  }
}
