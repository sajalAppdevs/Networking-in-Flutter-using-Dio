// data/repositories/product_repository.dart
import '../models/product.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService
  apiService; // Instance of the ApiService class to perform API requests.

  ProductRepository({required this.apiService});

  Future<List<Product>> getProducts() async {
    try {
      // Call the getProducts() method from the ApiService to fetch product data from the API.
      final data = await apiService.getProducts();

      // Extract the 'products' list from the API response data.
      final productsData = data['products'];

      // Map the 'products' list to a List of Product objects using the Product.fromJson() constructor.
      return productsData
          .map<Product>((json) => Product.fromJson(json))
          .toList();
    } catch (e) {
      // If an exception occurs during the API call, throw an exception with an error message.
      throw Exception('Failed to fetch products');
    }
  }
}