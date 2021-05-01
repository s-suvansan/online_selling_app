import '../main_index.dart';

class FireStoreService {
  // get product snapshot for stream build
  static Stream<QuerySnapshot> getProducts() {
    return Firestore.instance.collection(Global.PRODUCTS).orderBy(Global.POST_AT, descending: true).snapshots();
  }

  // get user favourite product snapshot for stream build
  static Stream<QuerySnapshot> getFavouriteProducts() {
    return Firestore.instance
        .collection(Global.PRODUCTS)
        // .orderBy(Global.POST_AT, descending: true)
        .where(
          Global.FAVOURITE_USER_IDS,
          arrayContains: Global.userInfo.uid,
        )
        .snapshots(includeMetadataChanges: true);
  }

  // favourite product function
  static void favouriteProduct({@required String docId}) {
    Firestore.instance.collection(Global.PRODUCTS).document(docId).updateData({
      Global.FAVOURITE_USER_IDS: FieldValue.arrayUnion([Global.userInfo.uid])
    });
  }

  // un favourite product function
  static void unFavouriteProduct({@required String docId}) {
    Firestore.instance.collection(Global.PRODUCTS).document(docId).updateData({
      Global.FAVOURITE_USER_IDS: FieldValue.arrayRemove([Global.userInfo.uid])
    });
  }

  // check is favorite
  static Future<bool> isFavouriteProduct({@required String docId}) async {
    bool _value = false;
    DocumentSnapshot doc = await Firestore.instance.collection(Global.PRODUCTS).document(docId).get();
    List _favouriteUserIds = List();
    _favouriteUserIds = doc.data[Global.FAVOURITE_USER_IDS];
    if (_favouriteUserIds != null && _favouriteUserIds.isNotEmpty) {
      _value = _favouriteUserIds.contains(Global.userInfo.uid);
    }
    return _value;
  }

  // get language when change language
  static Future<LanguageModel> getLanguage({@required String docName}) async {
    DocumentSnapshot doc = await Firestore.instance.collection(Global.LANGUAGE).document(docName).get();
    if (doc != null && doc.data != null) {
      return LanguageModel.fromJson(doc.data);
    }
    return null;
  }
  /* .catchError(
          (onError) => print("onErronFuck ${onError.toString()}"), */
}
