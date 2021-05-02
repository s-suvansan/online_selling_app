import '../../main_index.dart';

class HomeViewModel extends BaseViewModel {
  //variables
  List<ProductModel> _product = List<ProductModel>();
  bool _isLoading = false;

  //getter
  List<ProductModel> get product => _product;
  bool get isLoading => _isLoading;

  // on init function
  onInit() {
    _isLoading = true;
    // notifyListeners();
  }

  // get product details
  void getProductDetails(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData && snapshot.data.documents.length > 0) {
      _product = List<ProductModel>.from(snapshot.data.documents.map((x) => ProductModel.fromJson(x.data)));
      _isLoading = false;
    }
  }

  // open product info view
  void openProductInfo(BuildContext context, Widget widget) {
    App.showBottomPopup(context, widget, reduceHeightBy: 25.0);
  }

/*   onScroll(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollStartNotification) {
      // _onStartScroll(scrollNotification.metrics);

      print("start");
    } else if (scrollNotification is ScrollUpdateNotification) {
      if (_isDownScrool(pixel: scrollNotification.metrics.pixels)) {
        print("scroll up");
      } else {
        print("scroll down");
      }
    } else if (scrollNotification is ScrollEndNotification) {
      // _onEndScroll(scrollNotification.metrics);
      print("end");
    }
  }

  double _val = 0.0;
  bool _isDownScrool({double pixel}) {
    if (_val < pixel) {
      _val = pixel;
      return true;
    } else {
      _val = pixel;
      return false;
    }
  } */
}
