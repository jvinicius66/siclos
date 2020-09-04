/*
 * product_controller.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/product
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Controller of product
 */

import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'product_controller.g.dart';

@Injectable()
class ProductController = _ProductControllerBase with _$ProductController;

abstract class _ProductControllerBase with Store {}
