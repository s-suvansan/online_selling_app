import '../main_index.dart';

class FireStoreService {
  static CollectionReference _products;
  static CollectionReference _favouriteProducts;

  // get product snapshot for stream build
  static Stream<QuerySnapshot> getProducts() {
    _products = Firestore.instance.collection(Global.PRODUCTS);
    return _products.orderBy(Global.POST_AT, descending: true).snapshots();
  }

  // get user favourite product snapshot for stream build
  static Stream<QuerySnapshot> getFavouriteProducts() {
    _favouriteProducts = Firestore.instance.collection(Global.PRODUCTS);
    return _favouriteProducts
        .orderBy(Global.POST_AT, descending: true)
        .where(
          Global.FAVOURITE_USER_IDS,
          arrayContains: Global.userInfo.uid,
        )
        .snapshots(includeMetadataChanges: true);
  }

  // favourite product function
  static void favouriteProduct({@required String docId}) {
    // Firestore.instance.collection(Global.PRODUCTS).document(docId).updateData({"data": FieldValue.arrayUnion(obj)});
  }
}
