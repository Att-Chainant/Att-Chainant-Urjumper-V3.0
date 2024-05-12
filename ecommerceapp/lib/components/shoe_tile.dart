import 'package:flutter/material.dart';

class ShoeTile extends StatelessWidget {
  final String imagePath;
  final String shoeName;
  final String price;
  final String description;
  final Function()? onTap;

  ShoeTile({
    super.key,
    required this.imagePath,
    required this.shoeName,
    required this.price,
    required this.onTap,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView( // Added to allow scrolling when content exceeds the space
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Shoe picture
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(imagePath, fit: BoxFit.cover), // Ensure image fits well
            ),

            // Description
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                description,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            // Price + Details
            Padding( // Modified to include Padding for uniformity
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10), // Added vertical padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shoeName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\$$price',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  // Button to add to cart
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.all(12), // Reduced padding to avoid overflow
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
