import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/shoe.dart';

class AllShoesPage extends StatelessWidget {
  const AllShoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Shoes"),
        backgroundColor: Colors.blueGrey,  // Updated color for a more neutral, stylish look
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per row
              childAspectRatio: 0.8, // Aspect ratio of each grid item
              crossAxisSpacing: 10, // Horizontal space between items
              mainAxisSpacing: 10, // Vertical space between items
            ),
            itemCount: cart.getShoeList().length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              Shoe shoe = cart.getShoeList()[index];
              return Card(
                clipBehavior: Clip.antiAlias, // Added for better UI, gives a polished look to cards
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners for the cards
                ),
                elevation: 5, // Shadows to lift the card off the page
                child: InkWell(
                  onTap: () {
                    // Optionally add more detailed shoe page or quick view here
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch items to fit the card width
                    children: [
                      Expanded(
                        child: Image.asset(shoe.imagePath, fit: BoxFit.cover), // Full width image cover
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(shoe.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("\$${shoe.price}", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.add_shopping_cart),
                          label: Text("Add to Cart"),
                          onPressed: () {
                            Provider.of<Cart>(context, listen: false).addItemToCart(shoe);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added ${shoe.name} to cart!'))
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.blueGrey, // Text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
