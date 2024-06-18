import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easypizza/models/pizza.dart';
import 'package:go_router/go_router.dart';
import 'package:easypizza/providers/likes_provider.dart';
import 'package:easypizza/providers/cart_provider.dart';

class PizzasDetails extends StatelessWidget {
  final Pizza pizza;
  const PizzasDetails({required this.pizza, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pizza.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.go('/cart');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'images/pizza.png',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  pizza.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Price: ${pizza.price.toStringAsFixed(2)} €",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[800],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ingredients:",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pizza.ingredients
                        .map((ingredient) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                ingredient,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        return ElevatedButton(
                          onPressed: () {
                            cartProvider.addItem(pizza);
                          },
                          style: ElevatedButton.styleFrom(
                           
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Ajouter au Panier'),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    Consumer<LikesProvider>(
                      builder: (context, likesProvider, child) {
                        final isLiked = likesProvider.isLiked(pizza.id);
                        return IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                          onPressed: () {
                            if (isLiked) {
                              likesProvider.removeLike(pizza.id);
                            } else {
                              likesProvider.addLike(pizza.id);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
