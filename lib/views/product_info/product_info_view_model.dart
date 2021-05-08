import 'package:flutter/cupertino.dart';

import '../../main_index.dart';

class ProductInfoViewModel extends BaseViewModel {
  //variables
  PageController _pageController = PageController();
  ProductModel _product = ProductModel();
  bool _showMore = false;
  int _currentImageIndex = 0;

  //getter
  ProductModel get product => _product;
  bool get showMore => _showMore;
  int get currentImageIndex => _currentImageIndex;
  PageController get pageController => _pageController;

  // on init function
  void onInit(ProductModel productModel) {
    _product = productModel;
  }

  // expand the description part
  void showMoreDesc() {
    _showMore = !_showMore;
    notifyListeners();
  }

  // image change functon
  void onImageChange({int index}) {
    _currentImageIndex = index;
    notifyListeners();
  }

  // on image change arrows click functions
  void onArrowClick({bool isForward = true}) {
    if (isForward) {
      if (_currentImageIndex < _product.imageUrl.length - 1) {
        _currentImageIndex++;
        notifyListeners();
        _pageController.animateToPage(_currentImageIndex, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    } else {
      if (_currentImageIndex > 0) {
        _currentImageIndex--;
        notifyListeners();
        _pageController.animateToPage(_currentImageIndex, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    }
  }

  // launch call and sms
  void callAndSmsLauncher(BuildContext context, {@required String phoneNumber, bool isCall = true}) {
    String _url = "";

    if (isCall) {
      _url = "tel:$phoneNumber";
    } else {
      /* _url = "sms:$phoneNumber";  */ // for sms
      _url = "whatsapp://send?phone=$phoneNumber";
    }
    App.urlLaunch(url: _url).then((value) {
      if (!value) {
        print("Could not launch $_url");
        App.showInfoBar(
          context,
          msg: "${getIt<LanguageChange>().lang.sorryCouldnotOpen}",
          bgColor: BrandColors.dangers,
        );
      }
    });
  }

  // show setting bottom sheet
  void showPhoneNumbers(BuildContext context, {@required List<String> phoneNumber, bool isCall = true}) {
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      if (phoneNumber.length > 1) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => PhoneNumberList(
            phnNumbers: phoneNumber,
            isCall: isCall,
          ),
        ).then((val) {
          if (val != null) {
            callAndSmsLauncher(context, phoneNumber: val, isCall: isCall);
          }
        });
      } else {
        callAndSmsLauncher(context, phoneNumber: phoneNumber[0], isCall: isCall);
      }
    }
  }

  // pop with valur
  void popPhoneNumberList(BuildContext context, {@required String number}) {
    Navigator.of(context).pop(number);
  }

  // for open image full view
  openFullImageView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ImageViewer(images: _product.imageUrl)));
  }
}
