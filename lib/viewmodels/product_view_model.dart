import 'package:flutter/material.dart';
import '../data/models/product.dart';
import '../data/repositories/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductViewModel({required this.productRepository});

  List<Product> _products =
  []; // List to store product data fetched from the API.
  bool _loading =
  false; // Boolean flag to track if data is currently being fetched.
  String _errorMessage =
      ''; // String to store any error message that occurs during data fetching.

  List<Product> get products =>
      _products; // Getter method to access the list of products.
  bool get loading => _loading; // Getter method to access the loading flag.
  String get errorMessage =>
      _errorMessage; // Getter method to access the error message.

  Future<void> fetchProducts() async {
    _loading = true; // Set loading flag to true before making the API call.
    _errorMessage = ''; // Clear any previous error message.

    try {
      // Call the getProducts() method from the ProductRepository to fetch product data from the API.
      _products = await productRepository.getProducts();
    } catch (e) {
      // If an exception occurs during the API call, set the error message to display the error.
      _errorMessage = 'Failed to fetch products';
    } finally {
      // After API call is completed, set loading flag to false and notify listeners of data change.
      _loading = false;
      notifyListeners();
    }
  }
}