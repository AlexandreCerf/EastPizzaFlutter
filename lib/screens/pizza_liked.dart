import 'package:flutter/material.dart';
import 'package:easypizza/models/pizza.dart';
import 'package:go_router/go_router.dart';

class LikedPizzasScreen extends StatelessWidget {
  final List<Pizza> likedPizzas;

  const LikedPizzasScreen({super.key, required this.likedPizzas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pizzas Favorites",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: likedPizzas.length,
              itemBuilder: (context, index) {
                final pizza = likedPizzas[index];
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
                    onTap: () {
                      context.go('/details', extra: pizza);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.go('/');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Menu'),
                    ),
        ],
      ),
    );
  }
}
