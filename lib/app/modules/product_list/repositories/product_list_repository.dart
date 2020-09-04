import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/shared/constants.dart';
import 'package:siclos/app/shared/models/product_model.dart';

import 'interfaces/product_list_repository_interface.dart';

part 'product_repository.g.dart';

@Injectable()
class ProductRepository implements IProductRepository {
  final Dio client;

  ProductRepository(this.client);

  Future<List<ProductModel>> fetchProducts() async {
    final response = await client.get(PRODUCT_URL);
    return ProductModel.fromJsonList((response.data as List));
  }

  @override
  void dispose() {}
}
