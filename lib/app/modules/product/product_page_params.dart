import 'package:siclos/app/shared/models/product_model.dart';

class ProductPageParams {
  final ProductModel productModel;
  final bool isCart;

  ProductPageParams({this.productModel, this.isCart});
}
