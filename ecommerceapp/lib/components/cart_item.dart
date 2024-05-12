import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/shoe.dart';

class CartItem extends StatefulWidget {
  final Shoe shoe;
  CartItem({super.key, required this.shoe});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _quantity = 1;  // Default quantity

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
    // Optionally update quantity in the cart in your model
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
      // Optionally update quantity in the cart in your model
    }
  }

  // Remove item from cart
  void removeItemFromCart() {
    Provider.of<Cart>(context, listen: false).removeItemFromCart(widget.shoe);
    // Alert the user, shoe successfully removed from the cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Removed from your cart!',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Undo', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Provider.of<Cart>(context, listen: false).addItemToCart(widget.shoe);
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text('Close', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(), // Close the dialog
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        title: Text(
          widget.shoe.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('\$${widget.shoe.price}'),
        leading: Image.asset(widget.shoe.imagePath),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: _decreaseQuantity,
            ),
            Text('$_quantity'), // Display the current quantity
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _increaseQuantity,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => removeItemFromCart(),
            ),
          ],
        ),
      ),
    );
  }
}
