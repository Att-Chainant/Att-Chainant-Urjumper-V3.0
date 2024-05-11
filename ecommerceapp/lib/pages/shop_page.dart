import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/shoe.dart';
import '../components/shoe_tile.dart';
import '../components/message_tile.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text.toLowerCase();
    });
  }

  void addShoeToCart(Shoe shoe) {
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Successfully added!', style: TextStyle(color: Colors.white)),
        content: const Text('Check your cart for more details.', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue Shopping', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/cart');
            },
            child: const Text('Go to Cart', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        List<Shoe> filteredShoes = cart.getShoeList().where((shoe) {
          return shoe.name.toLowerCase().contains(_searchText) || shoe.description.toLowerCase().contains(_searchText);
        }).toList();

        return Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for products',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const MessageTile(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Hot Picks 🔥", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/allShoes'),
                    child: const Text('See all', style: TextStyle(color: Color.fromARGB(255, 133, 128, 171))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredShoes.length,
                itemBuilder: (context, index) {
                  Shoe individualShoe = filteredShoes[index];
                  return ShoeTile(
                    imagePath: individualShoe.imagePath,
                    shoeName: individualShoe.name,
                    price: individualShoe.price,
                    description: individualShoe.description,
                    onTap: () => addShoeToCart(individualShoe),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(color: Colors.white, thickness: 1),
            ),
          ],
        );
      },
    );
  }
}
