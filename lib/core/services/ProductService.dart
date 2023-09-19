import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/ColorWay.dart';
import '../model/Product.dart';
import '../model/ProductSize.dart';
import '../model/Review.dart';
import '../model/Search.dart';
import 'authentication.dart';

class ProductService extends ChangeNotifier {

  static List<Product> searchedProductData = searchedProductRawData.map((data) => Product.fromJson(data)).toList();

  ProductService()  {
    fetchProducts();
   // storeProducts();
  }

   List<Product>  products = [];
  storeProducts() async {
    CollectionReference productsCollection = FirebaseFirestore.instance.collection('Products');
    // for (var map in productRawData) {
    for (int i=0; i<categoryRawData.length;i++){
      DocumentReference docRef = productsCollection.doc(categoryRawData[i]['name'] as String?); // Automatically generate a new document ID
      await docRef.update({'Products':productRawData});
    }
      //DocumentReference docRef = productsCollection.doc('best offer'); // Automatically generate a new document ID
      //await docRef.update({'cdc':productRawData});
    // }
  }
  fetchProducts() async {
      FirebaseFirestore.instance.collection("Products").get().then(
           (querySnapshot) {
         //print("Successfully completed");
         for (var docSnapshot in querySnapshot.docs ) {
        //  if(docSnapshot.id != 'Popular Search') {
           if(docSnapshot.id == 'best offer') {
             List lenght = docSnapshot.data()!['Products'];
             for  (int i=0;i<lenght.length;i++){
               products.add(Product.fromJson(docSnapshot.data()['Products'][i]));
               print('---------------------'+  products[i].name + '------------------');
             }
            }
         }
         notifyListeners();
         CategoryProducts = products.where((product) => product.category == 'best offer').toList();},
       onError: (e) => print("Error completing: $e"),
     );
  }


  List<Product>  CategoryProducts = [];
  List<Product> filterProductsByName(List<Product> products, String targetName) {
    CategoryProducts = products.where((product) => product.category == targetName).toList();
    notifyListeners();
    return CategoryProducts;
  }




}

var categoryRawData = [
  {
    'featured': true,
    'icon_url': 'assets/icons/Discount.svg',
    'name': 'best offer',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/High-heels.svg',
    'name': 'woman shoes',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Woman-dress.svg',
    'name': 'woman dress',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Man-Clothes.svg',
    'name': 'man clothes',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Man-Pants.svg',
    'name': 'man pants',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Man-Shoes.svg',
    'name': 'man shoes',
  },
];

var productRawData = [
  {
    'name': 'Nike Waffle One',
    'price': 1429000,
    'rating': 4.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
          'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],
    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ],
    'image': [
      'assets/images/nikeblack.jpg',
      'assets/images/nikegrey.jpg',
    ],

  },
  // 2
  {
    'image': [
      'assets/images/nikegrey.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Nike Blazer Mid77 Vintage",
    'price': 1429000,
    'rating': 4.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
        'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],

    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },

  // 3
  {
    'image': [
      'assets/images/nikehoodie.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Nike Sportswear Swoosh",
    'price': 849000,
    'rating': 4.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
        'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],

    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
  // 4
  {
    'image': [
      'assets/images/adidasjacket.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Adidas T-SHIRT R.Y.V.",
    'price': 1900000,
    'rating': 4.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Adidas Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
        'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],

    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
];

var searchedProductRawData = [
  //1
  {
    'category' : '',
    'image': [
      'assets/images/search/searchitem6.jpg',
      'assets/images/nikegrey.jpg',
    ],
    'name': 'Air Jordan XXXVI SE PF',
    'price': 66.9,
    'rating': 4.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
        'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],
    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ],
  },
  // 2
  {
    'category' : '',
    'image': [
      'assets/images/search/searchitem3.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Air Jordan 1 Retro OG",
    'price': 66.9,
    'rating': 5.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
        'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],
    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
  // 3
  {
    'category' : '',
    'image': [
      'assets/images/search/searchitem5.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Jordan Point Lane",
    'price': 66.9,
    'rating': 5.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
        'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],
    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
  // 4
  {
    'category' : '',
    'image': [
      'assets/images/search/searchitem2.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Air Jordan 4 Crimson",
    'price': 66.9,
    'rating': 4.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
        'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],
    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
  // 5
  {
    'category' : '',
    'image': [
      'assets/images/search/searchitem4.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Jordan Delta 2 SE",
    'price': 66.9,
    'rating': 5.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
        'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],
    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
  // 6
  {
    'category' : '',
    'image': [
      'assets/images/search/searchitem1.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Jordan One Take 3",
    'price': 66.9,
    'rating': 4.0,
    'description': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': '000000',
      },
      {
        'name': 'blueGrey',
        'color': '6699CC',
      },
      {
        'name': 'pink',
        'color': 'FFC0CB',
      },
      {
        'name': 'white',
        'color': 'ffffff',
      },
    ],
    'sizes': [
      {
        'size': 36.0,
        'name': '36',
      },
      {
        'size': 37.0,
        'name': '37',
      },
      {
        'size': 38.0,
        'name': '38',
      },
      {
        'size': 42.0,
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review': 'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
];
