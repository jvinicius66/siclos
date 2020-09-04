/*
 * main.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage 
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Initialization app
*/

import 'package:flutter/material.dart';
import 'package:siclos/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() => runApp(ModularApp(module: AppModule()));
