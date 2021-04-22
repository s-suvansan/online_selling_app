import '../../main_index.dart';

class ProductInfoViewModel extends BaseViewModel {
  //variables
  ProductModel _product = ProductModel();

  //getter
  ProductModel get product => _product;

  // on init function
  void onInit(ProductModel productModel) {
    _product = productModel;
  }
}
