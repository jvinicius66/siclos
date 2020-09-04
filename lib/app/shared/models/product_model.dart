/*
 * product_model.dart
 *
 * @version     1.0
 * @package     lib
 * @subpackage  app/shared/models
 * @author      João Borges
 * @copyright   Copyright (c) 2020 João Borges Ltda. (https://www.linkedin.com/in/joaoborges80/)
 * @license     https://opensource.org/licenses/MIT
 * @description Product Model
*/

class ProductModel {
  int id;
  String name;
  String image;
  String description;
  double price;
  String category;

  /*
  * @method             : Constructor
  * @param[id]          : product id
  * @param[name]        : name of product
  * @param[image]       : image of product
  * @param[description] : description of product
  * @param[price]       : price of product
  * @param[category]    : category of product
  */
  ProductModel({this.id, this.name, this.image, this.description, this.category, this.price});

  /*
  * @method      : fromJson
  * @description : Load Product Model from json data
  * @param[map]  : Map with key and value json
  * @result      : Product Model
  */
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price']?.toDouble() ?? 0.0;
    image = json['image'] ?? '';
  }

  /*
  * @method      : fromJsonList
  * @description : Load list of Product Model from list in json
  * @param[list] : List of json converted
  * @result      : List of Product Model
  */
  static List<ProductModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ProductModel.fromJson(item)).toList();
  }

  /*
  * @method      : toJson
  * @description : Convert Product Model to json structure
  * @result      : Map os key and value to json 
  */
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.name;
    data['description'] = this.description;
    data['category'] = this.category;
    data['price'] = this.price;
    data['image'] = this.image ?? '';
    return data;
  }

  /*
  * @method      : toString
  * @description : Print the object Product Model
  * @result      : Text of data
  */
  toString() => 'id: $id, name: $name, image: $image';
}
