import '../../main_index.dart';

class ProductInfoView extends StatelessWidget {
  final ProductModel productModel;
  const ProductInfoView({Key key, @required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductInfoViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: BrandColors.shadowLight,
        appBar: CommonAppBar(
          title: "Product Info",
        ),
        body: Container(
          // height: App.getDeviceHight(context) - 25.0,
          child: Column(
            children: [
              _TopImagesView(),
            ],
          ),
        ),
      ),
      onModelReady: (model) => model.onInit(productModel),
      viewModelBuilder: () => ProductInfoViewModel(),
    );
  }
}

// top image view
class _TopImagesView extends ViewModelWidget<ProductInfoViewModel> {
  @override
  Widget build(BuildContext context, ProductInfoViewModel model) {
    return Container(
        height: 220.0,
        color: BrandColors.light,
        child: PageView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: model.product.imageUrl?.length,
          itemBuilder: (context, index) {
            return Image.network(
              model.product.imageUrl[index],
              fit: BoxFit.contain,
            );
          },
        ));
  }
}
