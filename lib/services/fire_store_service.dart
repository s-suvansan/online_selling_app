import '../main_index.dart';

class FireStoreService {
  static CollectionReference _products; /* = Firestore.instance.collection(Global.PRODUCTS); */

  // get product snapshot for stream build
  static Stream<QuerySnapshot> getProducts() {
    _products = Firestore.instance.collection(Global.PRODUCTS);
    // Query _orderQuery = _products.orderBy("postAt");
    return _products.snapshots();
  }
}
