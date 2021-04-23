import '../../main_index.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      builder: (context, model, child) => _ProductGridView(),
      onModelReady: (model) => model.onInit(),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

// grid view
class _ProductGridView extends ViewModelWidget<HomeViewModel> {
  _ProductGridView({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FireStoreService.getProducts(),
          builder: (context, snapshot) {
            model.getProductDetails(snapshot);
            return !model.isLoading
                ? Container(
                    margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: StaggeredGridView.countBuilder(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      itemCount: model.product.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => App.showBottomPopup(
                            context,
                            ProductInfoView(
                              productModel: model.product[index],
                            ),
                            reduceHeightBy: 25.0),
                        child: _ProductGridTile(
                          key: UniqueKey(),
                          index: index,
                        ),
                      ),
                      staggeredTileBuilder: (int index) => StaggeredTile.count(1, index.isEven ? 1.2 : 1.6),
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                  )
                : Center(
                    child: Loading(
                      needBg: true,
                      size: 20.0,
                      bgSize: 40.0,
                    ),
                  );
          }),
    );
  }
}

//grid tile
class _ProductGridTile extends ViewModelWidget<HomeViewModel> {
  final int index;

  _ProductGridTile({Key key, @required this.index}) : super(key: key, reactive: true);
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Container(
      decoration: BoxDecoration(
          color: BrandColors.glass,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: BrandColors.shadow.withOpacity(0.1),
              spreadRadius: 0.5,
              offset: Offset.zero,
              blurRadius: 2.0,
            ),
          ]),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
              image: (model.product[index].imageUrl != null && model.product[index].imageUrl.isNotEmpty)
                  ? model.product[index].imageUrl[0]
                  : NO_IMAGE,
            ),
          ),
          /* Positioned(
              height: 28.0,
              top: 8.0,
              right: 4.0,
              child: CircleAvatar(
                backgroundColor: BrandColors.dark.withOpacity(0.2),
                // radius: 28.0,
                child: App.svgImage(
                  svg: index.isOdd ? LIKE_FILL : LIKE,
                  height: 20.0,
                  color: index.isOdd ? BrandColors.brandColorLight : BrandColors.light,
                ),
              )), */
          Positioned(
            bottom: 0.0,
            child: Container(
              // height: 100.0,
              width: App.getDeviceWidth(context) * 0.47,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.8],
                    colors: [
                      BrandColors.glass,
                      BrandColors.dark.withOpacity(0.5),
                      // BrandColors.dark,
                      // BrandColors.dark,
                    ],
                  ),
                  // color: BrandColors.dark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: BrandColors.shadow.withOpacity(0.1),
                      spreadRadius: 0.5,
                      offset: Offset.zero,
                      blurRadius: 2.0,
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BrandTexts.titleBold(
                      text: model.product[index].title,
                      color: BrandColors.light,
                      maxLines: 2,
                    ),
                    BrandTexts.subTitleBold(
                      text: "${App.getPrice(model.product[index].price)}",
                      color: BrandColors.light,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BrandTexts.caption(
                          text: "${App.getTime(model.product[index].postAt)}",
                          color: BrandColors.light,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
