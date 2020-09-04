/*
 * home_controller.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/modules/home
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Controller of home page
*/

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store implements Disposable {
  /*
  * @variable    : pageViewConroller
  * @description : Controller of page navigation
  */
  final pageViewConroller = PageController();

  @override
  void dispose() {
    pageViewConroller.dispose();
  }
}
