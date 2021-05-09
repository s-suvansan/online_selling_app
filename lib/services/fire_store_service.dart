import '../main_index.dart';

class FireStoreService {
  // get product snapshot for stream build
  static Stream<QuerySnapshot> getProducts({int limit = 10}) {
    return Firestore.instance.collection(Global.PRODUCTS).orderBy(Global.POST_AT, descending: true).limit(limit).snapshots();
  }

  // get user favourite product snapshot for stream build
  static Stream<QuerySnapshot> getFavouriteProducts() {
    return Firestore.instance
        .collection(Global.PRODUCTS)
        .orderBy("${Global.FAVOURITE_USER_IDS}.${Global.userInfo.uid}", descending: true)
        .snapshots(includeMetadataChanges: true);
  }

  // favourite product function
  static Future<bool> favouriteProduct({@required String docId}) async {
    bool _value = true;
    try {
      await Firestore.instance.collection(Global.PRODUCTS).document(docId).updateData(
        {
          "${Global.FAVOURITE_USER_IDS}.${Global.userInfo.uid}": Timestamp.now(),
        },
      ).catchError((e) => _value = false);
    } catch (e) {
      print(e.toString());
      _value = false;
    }
    return _value;
  }

  // un favourite product function
  static Future<bool> unFavouriteProduct({@required String docId}) async {
    bool _value = true;
    try {
      await Firestore.instance.collection(Global.PRODUCTS).document(docId).updateData(
        {
          "${Global.FAVOURITE_USER_IDS}.${Global.userInfo.uid}": FieldValue.delete(),
        },
      ).catchError((e) => _value = false);
    } catch (e) {
      print(e.toString());
      _value = false;
    }
    return _value;
  }

  // check is favorite
  static Future<bool> isFavouriteProduct({@required String docId}) async {
    bool _value = false;
    DocumentSnapshot doc = await Firestore.instance.collection(Global.PRODUCTS).document(docId).get();
    if (doc.data != null &&
        doc.data[Global.FAVOURITE_USER_IDS] != null &&
        doc.data[Global.FAVOURITE_USER_IDS][Global.userInfo.uid] != null &&
        doc.data[Global.FAVOURITE_USER_IDS][Global.userInfo.uid] != "") {
      _value = true;
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

  //get phone numbers
  static Future<PhoneNumberModel> getPhoneNumbers() async {
    DocumentSnapshot doc = await Firestore.instance.collection(Global.PHONE_NUMBER).document(Global.NUMBERS).get();
    if (doc != null && doc.data != null) {
      return PhoneNumberModel.fromJson(doc.data);
    }
    return null;
  }
}
