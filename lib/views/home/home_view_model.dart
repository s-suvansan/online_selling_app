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
      if (_product.length < getIt<ScrollChange>().count) {
        getIt<ScrollChange>().setIsNotify = false;
      } else {
        getIt<ScrollChange>().setIsNotify = true;
      }
      _isLoading = false;
    }
  }

  // open product info view
  void openProductInfo(BuildContext context, Widget widget) {
    App.checkConnection(context).then((value) {
      if (value) {
        App.showBottomPopup(context, widget, reduceHeightBy: 25.0);
      }
    });
  }

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            // _hide.forward();
            print("unhide");
            break;
          case ScrollDirection.reverse:
            // _hide.reverse();
            print("hide");

            break;
          case ScrollDirection.idle:
            print("stable");

            break;
        }
      }
    }
    return false;
  }
}
