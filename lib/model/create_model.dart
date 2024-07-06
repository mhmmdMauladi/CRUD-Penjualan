import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addFood(String image, String name, String price, String cookingtime, String rate) async {
  final response = await http.post(
    Uri.parse('http://192.168.229.30/api_penjualan/create.php'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: <String, String>{
      'image': image,
      'nama': name,
      'price': price,
      'cookingtime': cookingtime,
      'rate': rate,
    },
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['message'] == 'created!') {
      print('Food added successfully');
    } else {
      print('Error: ${jsonResponse['message']}');
    }
  } else {
    throw Exception('Failed to add food');
  }
}
