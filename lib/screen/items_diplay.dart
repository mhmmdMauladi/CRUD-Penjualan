import 'package:flutter/material.dart';
import 'package:penjualan/colors.dart';
import 'package:penjualan/model/delete_model.dart';
import 'package:penjualan/model/items_model.dart';
import 'package:penjualan/model/update_model.dart';

class ItemsDisplay extends StatelessWidget {
  final List<FoodDetail> foodsItems;
  final VoidCallback onRefresh;

  const ItemsDisplay({
    super.key,
    required this.foodsItems,
    required this.onRefresh,
  });

  Future<void> _deleteFoodItem(BuildContext context, int id) async {
    try {
      await deleteFood(id);
      onRefresh();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete food item: $e')),
      );
    }
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, int id, String name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this item $name?'),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: primaryColors)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  const Text('Delete', style: TextStyle(color: primaryColors)),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteFoodItem(context, id);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editFoodItem(BuildContext context, FoodDetail food) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: food.name);
    final imageController = TextEditingController(text: food.image);
    final priceController = TextEditingController(text: food.price.toString());
    final cookingTimeController =
        TextEditingController(text: food.cookingtime.toString());
    final rateController = TextEditingController(text: food.rate.toString());

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Food Item'),
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
              child: const Text('Save', style: TextStyle(color: primaryColors)),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await updateFood(
                      food.id,
                      imageController.text,
                      nameController.text,
                      priceController.text,
                      cookingTimeController.text,
                      rateController.text,
                    );
                    onRefresh();
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error updating food: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update food item: $e')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: foodsItems.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 265,
      ),
      itemBuilder: (context, index) {
        FoodDetail food = foodsItems[index];
        return GestureDetector(
          child: Container(
            height: 265,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: food.image != 'not-image.png'
                            ? Image.network(
                                food.image,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'asset/not-image.png',
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        food.name,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Text(
                            '${food.cookingtime} \Menit',
                            style: const TextStyle(color: Colors.black38),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            food.rate.toString(),
                            style: const TextStyle(color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        '\Rp${food.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    color: primaryColors,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        _editFoodItem(context, food);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Colors.red,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        showDeleteConfirmationDialog(
                            context, food.id, food.name);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
