import 'package:flutter/material.dart';
import 'product_detail_page.dart'; // Import the ProductDetailPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Danh sách món ăn
  final List<Map<String, dynamic>> mainDishes = [
    {'name': 'Bánh Tằm', 'price': 60000, 'image': 'assets/banhtam.jpg'},
    {'name': 'Bánh Mì', 'price': 30000, 'image': 'assets/banhmi.jpg'},
  ];

  final List<Map<String, dynamic>> sideDishes = [
    {'name': 'Gỏi Cuốn', 'price': 10000, 'image': 'assets/goicuon.jpg'},
    {'name': 'Bì Cuốn', 'price': 10000, 'image': 'assets/bicuon.jpg'},
  ];

  final List<Map<String, dynamic>> beverages = [
    {'name': 'Trà Táo Xanh', 'price': 30000, 'image': 'assets/trataoxanh.jpg'},
    {'name': 'Trà Ổi', 'price': 30000, 'image': 'assets/traoi.jpg'},
  ];

  // Giỏ hàng
  List<Map<String, dynamic>> cart = [];

  // Thêm món vào giỏ hàng
  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cart.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} đã thêm vào giỏ hàng!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Số lượng tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách món ăn'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Món Chính', icon: Icon(Icons.restaurant)),
              Tab(text: 'Món Phụ', icon: Icon(Icons.local_dining)),
              Tab(text: 'Đồ Uống', icon: Icon(Icons.local_drink)),
            ],
          ),
          actions: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart', arguments: cart);
                  },
                ),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cart.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: TabBarView(
          children: [
            buildFoodList(mainDishes), // Tab Món chính
            buildFoodList(sideDishes), // Tab Món phụ
            buildFoodList(beverages),  // Tab Đồ uống
          ],
        ),
      ),
    );
  }

  Widget buildFoodList(List<Map<String, dynamic>> foodList) {
    return ListView.builder(
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        final item = foodList[index];
        return Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Hình ảnh món ăn
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Image.asset(
                  item['image'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              // Thông tin món ăn
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${item['price']} VND',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Column to hold both buttons
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nút Chi tiết
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the ProductDetailPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: item),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Chi tiết'),
                    ),
                    const SizedBox(height: 8), // Add spacing between buttons
                    // Nút Thêm
                    ElevatedButton(
                      onPressed: () => addToCart(item),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Thêm'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
