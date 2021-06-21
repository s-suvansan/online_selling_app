import '../../main_index.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

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
  const _ProductGridView({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Consumer<ScrollChange>(builder: (_, value, ___) {
      return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FireStoreService.getProducts(limit: value.count),
            builder: (context, snapshot) {
              model.getProductDetails(snapshot);
              return !model.isLoading
                  ? model.product.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
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
                              onTap: () => model.openProductInfo(
                                context,
                                ProductInfoView(
                                  productModel: model.product[index],
                                ),
                              ),
                              child: _ProductGridTile(
                                key: UniqueKey(),
                                index: index,
                              ),
                            ),
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.count(
                                    1, index.isEven ? 1.2 : 1.4),
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                        )
                      : Empty(
                          size: 150.0,
                          moveFromTopBy: 180.0,
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
    });
  }
}

//grid tile
class _ProductGridTile extends ViewModelWidget<HomeViewModel> {
  final int index;

  _ProductGridTile({Key key, @required this.index})
      : super(key: key, reactive: true);
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Container(
      // height: 150.0,
      decoration: BoxDecoration(
          color: BrandColors.glass,
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
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
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: App.cacheImage(
              (model.product[index].imageUrl != null &&
                      model.product[index].imageUrl.isNotEmpty &&
                      model.product[index].imageUrl[0] != "")
                  ? model.product[index].imageUrl[0]
                  : ""
              /* : NO_IMAGE */,
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Consumer<ThemeChange>(builder: (context, value, child) {
              return Consumer<LanguageChange>(builder: (context, value, child) {
                return Container(
                  // height: 100.0,
                  width: App.getDeviceWidth(context) * 0.455,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.1, 0.8],
                        colors: [
                          getIt<ThemeChange>().isDark
                              ? BrandColors.light.withOpacity(0.2)
                              : BrandColors.dark.withOpacity(0.2),
                          getIt<ThemeChange>().isDark
                              ? BrandColors.light.withOpacity(0.5)
                              : BrandColors.dark.withOpacity(0.5),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4.0),
                        bottomRight: Radius.circular(4.0),
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
                          color: getIt<ThemeChange>().isDark
                              ? BrandColors.dark1
                              : BrandColors.light,
                          maxLines: 2,
                        ),
                        BrandTexts.subTitleBold(
                          text: "${App.getPrice(model.product[index].price)}",
                          color: getIt<ThemeChange>().isDark
                              ? BrandColors.dark1
                              : BrandColors.light,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BrandTexts.caption(
                              text:
                                  "${App.getTime(model.product[index].postAt)}",
                              color: getIt<ThemeChange>().isDark
                                  ? BrandColors.dark1
                                  : BrandColors.light,
                              fontSize: getIt<LanguageChange>().languageCode ==
                                      Lang.English.code
                                  ? 12.0
                                  : 10.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
            }),
          ),
        ],
      ),
    );
  }
}
