import 'package:flutter/material.dart';
import 'shoe.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(name: 'Zoom FREAK', price: '236', imagePath: 'lib/images/ZoomFreak.png', description: 'The forward-thinking design of his latest signature shoe.'),
    Shoe(name: 'Air Jordans', price: '220', imagePath: 'lib/images/AirJordan.png', description: 'You\'ve got the hops and the speed—lace up in shoes that enhance what you bring to the court.'),
    Shoe(name: 'KD Treys', price: '240', imagePath: 'lib/images/KDTREY.png', description: 'A secure midfoot strap is suited for scoring binges and defensive stands, so that you can lock in and keep winning.'),
    Shoe(name: 'Kyrie 6', price: '190', imagePath: 'lib/images/Kyrie.png', description: 'Bouncy cushioning is paired with soft yet supportive foam for responsiveness and smooth heel-to-toe transitions.'),
    Shoe(name: '1 Element', price: '190', imagePath: 'lib/images/AirJordan1Element.jpg', description: 'Speedy grip'),
    Shoe(name: 'Air Max 270', price: '190', imagePath: 'lib/images/Air max 270.png', description: 'The Nike Air Max 270 is inspired by two icons of big Air: Air Max 180 and Air max 93.'),
    Shoe(name: 'SE MEN', price: '120', imagePath: 'lib/images/AirJordan1SEMen.jpg', description: 'Special Edition shoes. These pairs often feature one-of-a-kind designs and creative partnerships to honour special people or occasions.'), 
    Shoe(name: '1 Element', price: '120', imagePath: 'lib/images/AirJordan1Element.jpg', description: 'The latest Nike SB Dunk J-Pack Chicago keeps Jordan Brands relationship with skateboarding strong.'),
    Shoe(name: 'Panda', price: '120', imagePath: 'lib/images/Panda.png', description: 'The Nike Dunk Low Panda features a premium leather upper with bright overlays to provide the perfect level of color blocking.'),
    
  ];


  List<Shoe> userCart = [];

  List<Shoe> getShoeList() {
    return shoeShop;
  }

  List<Shoe> getUserCart() {
    return userCart;
  }

  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }

  void clearCart() {
    userCart.clear();
    notifyListeners();
  }
}
