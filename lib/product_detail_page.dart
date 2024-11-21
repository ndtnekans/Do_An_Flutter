import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                product['image'],
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Product name and price
            Text(
              product['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${product['price']} VND',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            // Product description (optional)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can add logic here to place the order
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${product['name']} đã được đặt!')),
          );
        },
        child: const Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.orange,
        tooltip: 'Đặt món', // Tooltip when hovering or long pressing the button
      ),
    );
  }
}