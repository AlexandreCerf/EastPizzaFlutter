import 'package:easypizza/screens/pizza_liked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:easypizza/screens/pizza_details.dart';
import 'package:easypizza/screens/pizza_master.dart';
import 'package:easypizza/screens/cart_screen.dart';
import 'package:easypizza/models/pizza.dart';
import 'package:easypizza/providers/likes_provider.dart';
import 'package:easypizza/providers/cart_provider.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PizzasMaster(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final pizza = state.extra as Pizza;
        return PizzasDetails(pizza: pizza);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/liked',
      builder: (context, state) {
        final likedPizzas = state.extra as List<Pizza>;
        return LikedPizzasScreen(likedPizzas: likedPizzas);
      },
    ),
  ],
);

Future<void> main() async {
 await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LikesProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
