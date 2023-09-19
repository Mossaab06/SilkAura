
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/Notification.dart';
import 'authentication.dart';

class NotificationService extends ChangeNotifier{
 // static List<UserNotification> listNotification = notificationListRawData.map((data) => UserNotification.fromJson(data)).toList();

  NotificationService(){
   // storenotificationList();
    fetchnotificationList();
  }

  List<UserNotification> listNotification= [];

  fetchnotificationList() async {
    FirebaseFirestore.instance.collection("Users").doc(Auth().currentUser!.uid).get().then(
          (querySnapshot) {
        //print('${querySnapshot.id}');
        List lenght = querySnapshot.data()!['Notifications'];
       // print(lenght.length);
        for  (int i=0;i<lenght.length;i++){
         // print(querySnapshot.data()!['Notifications'][i]);
          listNotification.add(UserNotification.fromJson(querySnapshot.data()!['Notifications'][i]));
        }
        notifyListeners();
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();
  }
  storenotificationList() async {
    CollectionReference productsCollection = FirebaseFirestore.instance.collection('Users');
    // for (var map in listExploreItemRawData) {
    DocumentReference docRef = productsCollection.doc(Auth().currentUser!.uid);
    // Automatically generate a new document ID
    await docRef.update({'Notifications' :notificationListRawData} );
    // }
  }

}

var notificationListRawData = [
  {
    'image_url': 'assets/images/nikeblack.jpg',
    'title': '#21070 Order Status',
    'date_time': '${DateTime.now()}',
    'description': 'Your order is out for delivery and will be arriving soon. Keep an eye out for our delivery team.',
  },
  {
    'image_url': 'assets/images/nikegrey.jpg',
    'title': '#30127 Order Canclelled',
    'date_time': '${DateTime.now()}',
    'description':
       'Unfortunately, your order has been cancelled. If you have any questions, please contact our support team. ',
  },
  {
    'image_url': 'assets/images/nikehoodie.jpg',
    'title': 'Payment Time limit for #1021820',
    'date_time': '${DateTime.now()}',
    'description': 'Unfortunately, there was an issue with processing your payment. Please update your payment information.'
                       },
  {
    'image_url': 'assets/images/nikeblack.jpg',
    'title': '#21070 Order Status',
    'date_time': '${DateTime.now()}',
    'description':'Your order is ready for pickup at our designated pickup location. Please bring your order confirmation.'
  },
];
