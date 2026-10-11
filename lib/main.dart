import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu du Restaurant',
      debugShowCheckedModeBanner: false,
      home: const MenuScreen(),
    );
  }
}


class Dish {
  final String name;
  final String category;
  final String price;
  final String description;
  final String imagePath;

  const Dish({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imagePath,
  });
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});


  final List<Dish> allDishes = const [

    Dish(
      name: 'Formule Midi',
      category: 'Formules',
      price: '15.90 €',
      description: 'Entrée + Plat du jour ou Plat + Dessert.',
      imagePath: 'assets/jour.webp',
    ),

    Dish(
      name: 'Salade César',
      category: 'Entrées',
      price: '8.50 €',
      description: 'Poulet grillé, croûtons et parmesan.',
      imagePath: 'assets/salade.webp',
    ),

    Dish(
      name: 'Entrecôte Grillée',
      category: 'Plats',
      price: '18.50 €',
      description: 'Servie avec des frites maison.',
      imagePath: 'assets/viande.jpg',
    ),

    Dish(
      name: 'Tiramisu Maison',
      category: 'Desserts',
      price: '6.50 €',
      description: 'Le classique italien au café.',
      imagePath: 'assets/tiramisu.webp',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu du Restaurant'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Modèle de données et plats ajoutés !'),
      ),
    );
  }
}