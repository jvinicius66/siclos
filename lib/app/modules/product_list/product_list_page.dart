/*
 * producet_list_page.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/product_list
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Page of list of products
*/

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/cart/cart_controller.dart';
import 'package:siclos/app/modules/product/product_page_params.dart';
import 'package:siclos/app/shared/models/product_model.dart';
import 'product_list_controller.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends ModularState<ProductListPage, ProductListController> with SingleTickerProviderStateMixin {
  /*
  * @variable    : _cart
  * @description : Cart Controller used in add Product operation
  */
  CartController _cart = Modular.get<CartController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearch(),
        _buildCategories(),
        _buildList(),
      ],
    );
  }

  /*
  * @method      : _buildSearch
  * @description : Build search widget 
  */
  Widget _buildSearch() {
    return Padding(
      padding: new EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: new TextField(
        autofocus: false,
        readOnly: true,
        showCursor: true,
        decoration: InputDecoration(
          hintText: 'Procurar produtos, categorias, lojas...',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }

  /*
  * @method      : _buildCategories
  * @description : Build categories widget 
  */
  Widget _buildCategories() {
    return Container(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _categoryIcon(Icons.shopping_basket, 'Ofertas'),
          _categoryIcon(Icons.airplanemode_active, 'Viagens'),
          _categoryIcon(Icons.smartphone, 'Smartphones'),
          _categoryIcon(Icons.tablet, 'Tablets'),
          _categoryIcon(Icons.videogame_asset, 'Videogame'),
          _categoryIcon(Icons.personal_video, 'Eletrônicos'),
          _categoryIcon(Icons.apartment_sharp, 'Imóveis'),
          _categoryIcon(Icons.restaurant, 'Restaurantes'),
          _categoryIcon(Icons.biotech, 'Laboratórios'),
          _categoryIcon(Icons.photo_camera, 'Fotografia'),
          _categoryIcon(Icons.local_hotel, 'Hotel'),
        ],
      ),
    );
  }

  /*
  * @method       : _categoryIcon
  * @description  : Build categories Icon widget 
  * @param[icon]  : Icon of presentation
  * @param[title] : Text of title presentation
  */
  Widget _categoryIcon(IconData icon, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.green[100],
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.green[200],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  /*
  * @method      : _buildList
  * @description : Build list items of presentation
  */
  Widget _buildList() {
    return Expanded(
      child: Observer(
        builder: (_) {
          if (controller.products.error != null) return _buildError();
          if (controller.products.value == null) return _buildLoading();

          var _list = controller.products.value;
          return ListView.builder(
            itemCount: _list.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => _buildCard(_list[index]),
          );
        },
      ),
    );
  }

  /*
  * @method      : _buildError
  * @description : Build widget of error
  */
  Widget _buildError() {
    return Center(
      child: RaisedButton(
        child: Text(
          'Algo inesperado aconteceu\nTente novamente',
          textAlign: TextAlign.center,
        ),
        onPressed: () => controller.fetchProducts(),
      ),
    );
  }

  /*
  * @method      : _buildLoading
  * @description : Build widget of loading
  */
  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  /*
  * @method         : _buildCard
  * @description    : Build card item of List
  * @param[product] : Model of Product to show data
  */
  Widget _buildCard(ProductModel product) {
    return Card(
      elevation: 1,
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        leading: _buildImage(product.image, product.id),
        title: _buildTitle(product.name),
        subtitle: _buildSubTitle(product),
        onTap: () => Modular.to.pushNamed('/product', arguments: ProductPageParams(productModel: product, isCart: false)),
      ),
    ); //
  }

  /*
  * @method         : _buildImage
  * @description    : Build image of product
  * @param[uriFile] : URI of the image file
  * @param[id]      : ID of product to make Hero animation
  */
  Widget _buildImage(String uriFile, int id) {
    return Hero(
      tag: 'product_$id',
      child: ExtendedImage.network(
        uriFile,
        fit: BoxFit.contain,
        cache: true,
        width: 100,
        height: 100,
        border: Border.all(color: Colors.black12, width: 1.0),
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.failed:
              return GestureDetector(
                child: Image.asset(
                  'assets/images/icon.png',
                  fit: BoxFit.contain,
                ),
                onTap: () => state.reLoadImage(),
              );
              break;
            case LoadState.loading:
              return Center(child: LinearProgressIndicator());
            case LoadState.completed:
              return ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                width: 100,
                height: 100,
              );
            default:
              return Center();
          }
        },
      ),
    );
  }

  /*
  * @method       : _buildTitle
  * @description  : Build title of product
  * @param[title] : Title of presentation
  */
  Widget _buildTitle(String title) {
    return Text(title);
  }

  /*
  * @method       : _buildSubTitle
  * @description  : Build description, price and buttons of cad product
  */
  Widget _buildSubTitle(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.description,
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${product.price.toStringAsFixed(2)}',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Hind',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red[200],
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.blue[200],
                    ),
                    onPressed: () => _cart.addProduct(product),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
