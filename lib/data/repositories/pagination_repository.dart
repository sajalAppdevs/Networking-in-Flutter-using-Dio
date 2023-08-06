// data/repositories/pagination_repository.dart
import '../models/pixelpay_photo.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class PaginationRepository {
  final ApiService
  apiService; // Instance of the ApiService class to perform API requests.

  PaginationRepository({required this.apiService});

  /*Future<List<Product>> getProducts() async {
    try {
      // Call the getProducts() method from the ApiService to fetch product data from the API.
      final data = await apiService.getPhotos();

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
  }*/


 /* Future<List<PixelPay>> getPhotos(int page, String search) async {
    try {

      // Call the getProducts() method from the ApiService to fetch product data from the API.
      final data = await apiService.getPhotos(page,search);
      // Map the API response data to a List of User objects using the User.fromJson() constructor.
      return data.map((json) => User.fromJson(json)).toList();

    } catch (e) {
      // If an exception occurs during the API call, throw an exception with an error message.
      throw Exception('Failed to fetch products');
    }
  }*/

  Future<Map<String, dynamic>> getPhotos(String query, int page) async {
    try {
      return await apiService.getPhotos(page, query);
    } catch (e) {
      // If an exception occurs during the API call, throw an exception with an error message.
      throw Exception('Failed to fetch products');
    }
  }
}