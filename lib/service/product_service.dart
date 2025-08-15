import 'dart:convert';
import 'package:e_com_task/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String baseUrl =
      "https://klinq.com/rest/V1/productdetails/6701/253620?lang=en&store=KWD";

  static Future<Product> fetchProductDetails() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Product.fromJson(jsonData);
    } else {
      throw Exception("Failed to load product details");
    }
  }
}
