import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/cart/cart_controller.dart';
import 'package:siclos/app/shared/models/product_model.dart';
import 'package:siclos/app/shared/utils/message.dart';
import 'product_controller.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  const ProductPage({Key key, @required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ModularState<ProductPage, ProductController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
          'DETALHES DO PRODUTO',
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
              _buildAddCart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        Hero(
          tag: 'product_${widget.product.id}',
          child: Center(
            child: ExtendedImage.network(
              widget.product.image,
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

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Text(
        widget.product.name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _buildDescription() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.product.description,
        textAlign: TextAlign.justify,
        style: TextStyle(
          height: 1.5,
          color: Color(0xFF6F8398),
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildAddCart() {
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
            onPressed: () {},
          ),
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
              _cart.addProduct(widget.product);
              Message.snak(_scaffoldKey, 'Produto adicionando no carrinho');
            },
          ),
        ),
      ],
    );
  }

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
                widget.product.price.toStringAsFixed(2),
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
