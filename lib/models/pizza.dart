import 'package:uuid/uuid.dart';

class Pizza{
  
   String id;
   double price;
   String name;
   List<String> ingredients;
   Category category;
   

  Pizza({required this.name, required this.price, required this.ingredients, required this.category}): id = const Uuid().v4();

}

enum Category {
  rossa,
  bianca,
  veggie,
}
