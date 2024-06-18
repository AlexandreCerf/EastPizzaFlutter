import 'dart:convert';

import 'package:easypizza/models/discount.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:easypizza/data/pizzas.dart' as db;
import 'package:go_router/go_router.dart';
import 'package:easypizza/providers/likes_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class PizzasMaster extends StatelessWidget {
  const PizzasMaster({super.key});

  @override
  Widget build(BuildContext context) {
Future<void> subscribeToDiscounts() async {
      await dotenv.load(fileName: ".env");

      final Uri wsUrl = Uri.parse(dotenv.env["WEBSOCKET_API"]!);
      final channel = WebSocketChannel.connect(wsUrl);

      await channel.ready;

      //abonnement au serveur websocket
      channel.sink.add(
        jsonEncode(
          {"collection": "discounts", "type": "subscribe"},
        ),
      );

      channel.stream.listen((data) {
        final Map<String, dynamic> response = jsonDecode(data);


        //print(response);

        if(response["type"] == "subscription"){
          print(response["data"].length);

          //for(var Discount in response["data"]){
          //  print(Discount["code"]);
          //}

          //print(response["data"][0]);

          final Discount lastDiscount = Discount.fromJson(response["data"][0]);
          
          final snackBar = SnackBar(
            content: Row(
              children: [
                const Icon(Icons.local_offer, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Center(
                    child: Text(
                      'PROMOTION: ${lastDiscount.code}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.deepOrange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
        }

        // for (var element in data["data"]) {
        //   print(element);
        // }
      }, onError: (error) {
        if (kDebugMode) {
          print(error);
        }
      });
    }

    subscribeToDiscounts();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EasyPizzas : Pizza de fou",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              final likesProvider = Provider.of<LikesProvider>(context, listen: false);
              final likedPizzas = db.pizzas.where((pizza) => likesProvider.isLiked(pizza.id)).toList();
              context.go('/liked', extra: likedPizzas);
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: db.pizzas.length,
          itemBuilder: (context, index) {
            final pizza = db.pizzas[index];
            return Consumer<LikesProvider>(
              builder: (context, likesProvider, child) {
                final isLiked = likesProvider.isLiked(pizza.id);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'images/pizza.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      pizza.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${pizza.price.toStringAsFixed(2)} € - ${pizza.ingredients.length} ingrédients",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (isLiked) {
                          likesProvider.removeLike(pizza.id);
                        } else {
                          likesProvider.addLike(pizza.id);
                        }
                      },
                    ),
                    onTap: () {
                      context.go('/details', extra: pizza);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
