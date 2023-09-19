
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/ExploreItem.dart';
import '../model/ExploreUpdate.dart';

class ExploreService extends ChangeNotifier {
  // static List<ExploreItem> listExploreItem = listExploreItemRawData.map((data) => ExploreItem.fromJson(data)).toList();
//  static List<ExploreUpdate> listExploreUpdateItem = listExploreUpdateItemRawData.map((data) => ExploreUpdate.fromJson(data)).toList();
  ExploreService (){
   // storeImagesUrl();
    fetchExploreItems();
    //storeExploreUpdateItem();
    fetchExploreUpdateItems();
  }

  List<ExploreItem> listExploreItem = [] ;
  List<ExploreUpdate> listExploreUpdateItem = [] ;

  storeExploreUpdateItem() async {
    CollectionReference productsCollection = FirebaseFirestore.instance.collection('Explore');
    // for (var map in listExploreItemRawData) {
    DocumentReference docRef = productsCollection.doc('ExploreUpdateItem');
    // Automatically generate a new document ID
    await docRef.set({'ExploreUpdateItem' :listExploreUpdateItemRawData} );
    // }
  }
  fetchExploreUpdateItems() async {
    FirebaseFirestore.instance.collection("Explore").doc('ExploreUpdateItem').get().then(
          (querySnapshot) {
          print('${querySnapshot.id}');
          List lenght = querySnapshot.data()!['ExploreUpdateItem'];
          for  (int i=0;i<lenght.length;i++){
            listExploreUpdateItem.add(ExploreUpdate.fromJson(querySnapshot.data()!['ExploreUpdateItem'][i]));
          }
          notifyListeners();
          },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();
  }

  storeExploreItems() async {
    CollectionReference productsCollection = FirebaseFirestore.instance.collection('Explore');
    // for (var map in listExploreItemRawData) {
    DocumentReference docRef = productsCollection.doc('ExploreItems');
    // Automatically generate a new document ID
    await docRef.set({'ExploreItems' :listExploreItemRawData} );
    // }
  }
  fetchExploreItems() async {
    FirebaseFirestore.instance.collection("Explore").doc('ExploreItems').get().then(
          (querySnapshot) {
        print('${querySnapshot.id}');
        List lenght = querySnapshot.data()!['ExploreItems'];
        for  (int i=0;i<lenght.length;i++){
          listExploreItem.add(ExploreItem.fromJson(querySnapshot.data()!['ExploreItems'][i]));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();
  }


}



var listExploreItemRawData = [
  {'image_url': 'assets/images/explore1.jpg'},
  {'image_url': 'assets/images/explore2.jpg'},
  {'image_url': 'assets/images/explore3.jpg'},
  {'image_url': 'assets/images/explore4.jpg'},
  {'image_url': 'assets/images/explore5.jpg'},
  {'image_url': 'assets/images/explore6.jpg'},
  {'image_url': 'assets/images/explore7.jpg'},
  {'image_url': 'assets/images/explore8.jpg'},
  {'image_url': 'assets/images/explore9.jpg'},
  {'image_url': 'assets/images/explore10.jpg'},
  {'image_url': 'assets/images/explore11.jpg'},
  {'image_url': 'assets/images/explore12.jpg'},
  {'image_url': 'assets/images/explore13.jpg'},
  {'image_url': 'assets/images/explore14.jpg'},
  {'image_url': 'assets/images/explore15.jpg'},
  {'image_url': 'assets/images/explore16.jpg'},
];

var listExploreUpdateItemRawData = [
  {
    'logo_url': 'assets/images/zaralogo.jpg',
    'image': 'assets/images/update1.jpg',
    'store_name': 'Zara Indonesia',
    'caption': 'The jacket is quite soft on the inside. Rib hem collar. Long sleeves, elastic cuffs. Various paspoil pockets on the hips and pocket details on the inside.',
  },
  {
    'logo_url': 'assets/images/nikelogo.jpg',
    'image': 'assets/images/update1.jpg',
    'store_name': 'Nike Indonesia',
    'caption':
        'Suit up like the pros in the Brooklyn Nets City Edition Swingman Shorts. Made from smooth, lightweight fabric with sweat-wicking technology, they have authentic team colours and details that match what the players wear during games. This product is made from 100% recycled polyester fibres.',
  },
];
