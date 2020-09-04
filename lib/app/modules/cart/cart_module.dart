import 'package:flutter_modular/flutter_modular.dart';

import 'cart_page.dart';

class CartModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => CartPage()),
      ];

  static Inject get to => Inject<CartModule>.of();
}
