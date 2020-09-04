import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:siclos/app/modules/product_list/repositories/product_list_repository.dart';
import 'package:siclos/app/shared/models/product_model.dart';

part 'product_list_controller.g.dart';

@Injectable()
class ProductListController = _ProductListControllerBase with _$ProductListController;

abstract class _ProductListControllerBase with Store {
  final ProductRepository repository;

  _ProductListControllerBase(this.repository) {
    fetchProducts();
  }

  @observable
  ObservableFuture<List<ProductModel>> products;

  @action
  fetchProducts() => products = repository.fetchProducts().asObservable();
}
