import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> cart;

  @override
  Widget build(BuildContext context) {
    // Receive the cart data from the previous page
    cart = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>;

    // Calculate the total price
    double getTotalPrice() {
      return cart.fold(0, (sum, item) => sum + item['price']);
    }

    // Map to track the quantity of items in the cart
    Map<String, dynamic> cartWithQuantity = {};
    for (var item in cart) {
      if (cartWithQuantity.containsKey(item['name'])) {
        cartWithQuantity[item['name']]['quantity'] += 1;
      } else {
        cartWithQuantity[item['name']] = {
          'price': item['price'],
          'image': item['image'],
          'quantity': 1,
        };
      }
    }

    // Remove item from cart
    void removeFromCart(String name) {
      setState(() {
        cartWithQuantity.remove(name);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Món đã bị xóa khỏi giỏ hàng!')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 4,
      ),
      body: cart.isEmpty
          ? const Center(
        child: Text(
          'Giỏ hàng của bạn đang trống!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tổng tiền: ${getTotalPrice()} VND',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartWithQuantity.keys.length,
              itemBuilder: (context, index) {
                final itemName = cartWithQuantity.keys.elementAt(index);
                final item = cartWithQuantity[itemName];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item['image'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      itemName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      '${item['price']} VND x ${item['quantity']} = ${item['price'] * item['quantity']} VND',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_shopping_cart, color: Colors.red),
                      onPressed: () {
                        removeFromCart(itemName);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đặt món thành công!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
              ),
              child: const Text(
                'Gọi món',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}