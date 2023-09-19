
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/Search.dart';
import 'authentication.dart';

class SearchService extends ChangeNotifier{
//  static List<SearchHistory> listSearchHistory = listSearchHistoryRawData.map((data) => SearchHistory.fromJson(data)).toList();
 // static List<PopularSearch> listPopularSearch = listPopularSearchRawData.map((data) => PopularSearch.fromJson(data)).toList();

  SearchService(){
    //storeSearchHistory();
    fetchSearchHistory();
    //storePopularSearch();
    fetchPopularSearch();
  }


  List<SearchHistory> listSearchHistory = [];
  storeSearchHistory() async {
    CollectionReference productsCollection = FirebaseFirestore.instance.collection('Users');
    // for (var map in listExploreItemRawData) {
    DocumentReference docRef = productsCollection.doc(Auth().currentUser!.uid);
    // Automatically generate a new document ID
    await docRef.update({'searchHistory' :listSearchHistoryRawData} );
    // }
  }
  fetchSearchHistory() async {
    FirebaseFirestore.instance.collection("Users").doc(Auth().currentUser!.uid).get().then(
          (querySnapshot) {
        print('${querySnapshot.id}');
        List lenght = querySnapshot.data()!['searchHistory'];
        print(lenght.length);
        for  (int i=0;i<lenght.length;i++){
          print(querySnapshot.data()!['searchHistory'][i]);
          listSearchHistory.add(SearchHistory.fromJson(querySnapshot.data()!['searchHistory'][i]));
        }
        notifyListeners();
      },
      onError: (e) => print("Error completing: $e"),
    );
    // notifyListeners();
  }

  List<PopularSearch> listPopularSearch = [];
  storePopularSearch() async {
    CollectionReference productsCollection = FirebaseFirestore.instance.collection('Products');
    // for (var map in listExploreItemRawData) {
    DocumentReference docRef = productsCollection.doc('Popular Search');
    // Automatically generate a new document ID
    await docRef.update({'Popular Search' :listPopularSearchRawData} );
    // }
  }
  fetchPopularSearch() async {
    FirebaseFirestore.instance.collection("Products").doc('Popular Search').get().then(
          (querySnapshot) {
        print('${querySnapshot.id}');
        List lenght = querySnapshot.data()!['Popular Search'];
        print(lenght.length);
        for  (int i=0;i<lenght.length;i++){
          print(querySnapshot.data()!['Popular Search'][i]);
          listPopularSearch.add(PopularSearch.fromJson(querySnapshot.data()!['Popular Search'][i]));
        }
        notifyListeners();
      },
      onError: (e) => print("Error completing: $e"),
    );
    // notifyListeners();
  }

}

var listSearchHistoryRawData = [
  {'title': 'Nike Air Jordan'},
  {'title': 'Adidas Alphabounce'},
  {'title': 'Curry 5'},
  {'title': 'Jordan BRED'},
  {'title': 'Heiden Heritage Xylo'},
  {'title': 'Ventela Public'},
];


var listPopularSearchRawData = [
  {
    'title': 'Heiden Heritage',
    'image_url': 'assets/images/search/popularsearchitem8.jpg',
  },
  {
    'title': 'Tech Wear',
    'image_url': 'assets/images/search/popularsearchitem4.jpg',
  },
  {
    'title': 'Local Brand',
    'image_url': 'assets/images/search/popularsearchitem7.jpg',
  },
  {
    'title': 'Flannel Hoodie',
    'image_url': 'assets/images/search/popularsearchitem3.jpg',
  },
  {
    'title': 'Sport Shoes',
    'image_url': 'assets/images/search/popularsearchitem6.jpg',
  },
  {
    'title': 'Black Tshirt',
    'image_url': 'assets/images/search/popularsearchitem2.jpg',
  },
  {
    'title': 'Sport Wear',
    'image_url': 'assets/images/search/popularsearchitem5.jpg',
  },
  {
    'title': 'Oversized Tshirt',
    'image_url': 'assets/images/search/popularsearchitem1.jpg',
  },
];
