import '../../main_index.dart';

class HomeViewModel extends BaseViewModel {
  List<String> _imageList = [
    'https://cdn.pixabay.com/photo/2021/03/21/13/36/boy-6112145_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
    'https://cdn.pixabay.com/photo/2021/01/22/20/16/heron-5941013_960_720.jpg'
  ];
  List<String> get imageList => _imageList;

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
