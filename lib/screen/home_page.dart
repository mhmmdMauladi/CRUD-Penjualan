import 'package:flutter/material.dart';
import 'package:penjualan/colors.dart';
import 'package:penjualan/model/create_model.dart';
import 'package:penjualan/model/items_model.dart';
import 'package:penjualan/screen/header_page.dart';
import 'package:penjualan/screen/items_diplay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<FoodDetail>> futureFoodsItems;

  @override
  void initState() {
    super.initState();
    futureFoodsItems = fetchFoodDetail();
  }

  void _refreshFood() {
    setState(() {
      futureFoodsItems = fetchFoodDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        selectedItemColor: primaryColors,
        unselectedItemColor: Colors.green[200],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favorite',
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          const HeaderParts(),
          FutureBuilder<List<FoodDetail>>(
            future: futureFoodsItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return ItemsDisplay(
                  foodsItems: snapshot.data!,
                  onRefresh: _refreshFood,
                );
              } else {
                return const Center(child: Text('No food items available'));
              }
            },
          ),
          const SizedBox(
            height: 70,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFoodDialog(context);
        },
        backgroundColor: const Color.fromARGB(255, 19, 206, 112),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showAddFoodDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final imageController = TextEditingController();
    final priceController = TextEditingController();
    final cookingTimeController = TextEditingController();
    final rateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Food Item'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: imageController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cookingTimeController,
                    decoration:
                        const InputDecoration(labelText: 'Cooking Time'),
                  ),
                  TextFormField(
                    controller: rateController,
                    decoration: const InputDecoration(labelText: 'Rate'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a rate';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: primaryColors)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add', style: TextStyle(color: primaryColors)),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await addFood(
                      imageController.text,
                      nameController.text,
                      priceController.text,
                      cookingTimeController.text,
                      rateController.text,
                    );
                    _refreshFood();
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error adding food: $e');
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
