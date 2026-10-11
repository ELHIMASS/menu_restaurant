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
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const MenuScreen(),
    );
  }
}

// Modèle de données pour un Plat
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

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Liste des catégories disponibles
  final List<String> categories = [
    'Formules',
    'Entrées',
    'Plats',
    'Desserts',
  ];

  // Catégorie sélectionnée par défaut
  String selectedCategory = 'Formules';

  // Liste de données en dur pour les plats avec les images locales
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
    // Filtrer les plats en fonction de la catégorie sélectionnée
    List<Dish> filteredDishes = allDishes
        .where((dish) => dish.category == selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu du Restaurant'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Barre de sélection des catégories (défilement horizontal)
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String cat = categories[index];
                bool isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: Colors.orange,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = cat;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),

          // 2. Liste verticale des plats filtrés
          Expanded(
            child: ListView.builder(
              itemCount: filteredDishes.length,
              itemBuilder: (context, index) {
                return DishCard(dish: filteredDishes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Composant visuel réutilisable pour afficher un plat sous forme de carte (Card)
class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // Image locale du plat
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              dish.imagePath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          // Informations du plat
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dish.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dish.price,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dish.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}