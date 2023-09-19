
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/services/authentication.dart';
import 'package:flutter/foundation.dart';

import '../model/Cart.dart';
import '../model/Product.dart';

class CartService extends ChangeNotifier{
  // List<Cart> cartData = cartRawData.map((data) => Cart.fromJson(data)).toList();


  CartService(){
   // storeCartData();
    fetchCartData();
    calculateTotalCartPrice(cartData);
  }

  List<Cart> cartData= [];
  fetchCartData() async {
    FirebaseFirestore.instance.collection("Users").doc(Auth().currentUser!.uid).get().then(
          (querySnapshot) {
        print('${querySnapshot.id}');
        List lenght = querySnapshot.data()!['cart'];
        print(lenght.length);
        for  (int i=0;i<lenght.length;i++){
          print(querySnapshot.data()!['cart'][i]);
          cartData.add(Cart.fromJson(querySnapshot.data()!['cart'][i]));
        }
        notifyListeners();
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();
  }


  storeCartData() async {
    CollectionReference productsCollection = FirebaseFirestore.instance.collection('Users');
    // for (var map in listExploreItemRawData) {
    DocumentReference docRef = productsCollection.doc(Auth().currentUser!.uid);

    print('all go so far ');

    List<Map<String, dynamic>> cartDataMapList = cartData.map((cart) => cart.toJson()).toList();
    await docRef.update({'cart': cartDataMapList})
        .then((_) {
      print('Cart data updated successfully');
    })
        .catchError((error) {
      print('Error updating cart data: $error');
    });
    // }
  }



  changeCount(int index,bool add){
    if(add) {
        cartData[index].count++;

    } else {
        if(cartData[index].count != 0 ){
         cartData[index].count--;}
    }
    calculateTotalCartPrice(cartData);
    notifyListeners();
  }

  List <int> selectedItems= [];
  selectItems(int index) {
    selectedItems.contains(index)?
    selectedItems.remove(index):
    selectedItems.add(index);
    notifyListeners();
  }

   removeItems() {
    for (int i = selectedItems.length - 1; i >= 0; i--) {
      int selectedIndex = selectedItems[i];
      if (selectedIndex >= 0 && selectedIndex < cartData.length) {
        cartData.removeAt(selectedIndex);
        selectedItems.removeAt(i);
      }
    }
    calculateTotalCartPrice(cartData);
    notifyListeners();
    storeCartData();
  }
   addToCart (Product product,int productCount){
    cartData.add(Cart(image: product.image, name: product.name, price: (product.price*productCount).toInt(), count: productCount));
    calculateTotalCartPrice(cartData);
    storeCartData();
  }

   double totalCartPrice= 0;

   calculateTotalCartPrice(List<Cart> cart){
    totalCartPrice=00;
    for (int i=0 ; i<cart.length;i++){
      totalCartPrice=totalCartPrice+(cart[i].price*cart[i].count);
    }
    notifyListeners();
  }



}

var cartRawData = [
  {
    'image': [
      'assets/images/nikeblack.jpg',
      'assets/images/nikegrey.jpg',
    ],
    'name': 'Nike Waffle One',
    'price': 1,
    'count': 1,
  },
  // 2
  {
    'image': [
      'assets/images/nikegrey.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Nike Blazer Mid77 Vintage",
    'price': 1,
    'count': 1,
  },
  // 3
  {
    'image': [
      'assets/images/nikehoodie.jpg',
      'assets/images/nikehoodie.jpg',
    ],
    'name': "Nike Sportswear Swoosh",
    'price': 1,
    'count': 1,
  },
];
