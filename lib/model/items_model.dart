import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodDetail {
  final int id;
  final String image;
  final String name;
  final String price;
  final String cookingtime;
  final String rate;

  FoodDetail({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.cookingtime,
    required this.rate,
  });

  factory FoodDetail.fromJson(Map<String, dynamic> json) {
    return FoodDetail(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      image: json['image']?.isNotEmpty == true
          ? json['image']
          : 'not-image.png',
      name: json['nama'] ?? '',
      price: json['price'] ?? '',
      cookingtime: json['cookingtime'] ?? '',
      rate: json['rate'] ?? '',
    );
  }
}

Future<List<FoodDetail>> fetchFoodDetail() async {
  final response = await http.get(Uri.parse('http://192.168.229.30/api_penjualan/read.php'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => FoodDetail.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load food detail');
  }
}
