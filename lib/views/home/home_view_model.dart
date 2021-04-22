import '../../main_index.dart';

class HomeViewModel extends BaseViewModel {
  //variables
  List<ProductModel> _product = List<ProductModel>();

  //getter
  List<ProductModel> get product => _product;

  // get product details
  void getProductDetails(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData && snapshot.data.documents.length > 0) {
      _product = List<ProductModel>.from(snapshot.data.documents.map((x) => ProductModel.fromJson(x.data)));
      // notifyListeners();
    }
  }
}
