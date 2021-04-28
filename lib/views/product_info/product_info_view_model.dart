import '../../main_index.dart';

class ProductInfoViewModel extends BaseViewModel {
  //variables
  ProductModel _product = ProductModel();
  bool _showMore = false;

  //getter
  ProductModel get product => _product;
  bool get showMore => _showMore;

  // on init function
  void onInit(ProductModel productModel) {
    _product = productModel;
  }

  // expand the description part
  void showMoreDesc() {
    _showMore = !_showMore;
    notifyListeners();
  }
}
