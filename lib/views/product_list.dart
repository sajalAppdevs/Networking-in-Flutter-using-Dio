import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_view_model.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();

    // Fetch product data when the state object is inserted into the tree.
    final productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    productViewModel.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, productViewModel, _) {
          if (productViewModel.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (productViewModel.errorMessage.isNotEmpty) {
            return Center(
              child: Text(productViewModel.errorMessage),
            );
          } else {
            return ListView.builder(
              itemCount: productViewModel.products.length,
              itemBuilder: (context, index) {
                final product = productViewModel.products[index];

                // Display a list of products with their name, category, and price.
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.category),
                  trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
