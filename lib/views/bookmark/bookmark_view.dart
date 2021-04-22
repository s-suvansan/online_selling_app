import '../../main_index.dart';

class BookmarkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      builder: (context, model, child) => _FavouriteList(),
      viewModelBuilder: () => BookmarkViewModel(),
    );
  }
}

class _FavouriteList extends ViewModelWidget<BookmarkViewModel> {
  _FavouriteList({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, BookmarkViewModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: FireStoreService.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "No Data",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (snapshot.data == null || !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            model.getProductDetails(snapshot);
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: model.product.length,
              itemBuilder: (context, index) => _FavouriteListTile(
                key: UniqueKey(),
                index: index,
              ),
              separatorBuilder: (context, i) => SizedBox(height: 8.0),
            );
          }),
    );
  }
}

class _FavouriteListTile extends ViewModelWidget<BookmarkViewModel> {
  final int index;
  // final ProductModel product;

  _FavouriteListTile({Key key, @required this.index}) : super(key: key, reactive: true);
  @override
  Widget build(BuildContext context, BookmarkViewModel model) {
    return Container(
      decoration: BoxDecoration(
          color: BrandColors.light,
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
      width: App.getDeviceWidth(context),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      height: 110.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: App.svgImage(
                        svg: LIKE_FILL,
                        height: 20.0,
                        color: BrandColors.brandColorLight,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: BrandTexts.commonText(
                        text: "${model.product[index].title}",
                        color: BrandColors.dark,
                        maxLines: 1,
                        fontSize: 16.0,
                        fontWeight: BrandTexts.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                BrandTexts.caption(
                  text: "${model.product[index].desc}",
                  color: BrandColors.dark,
                  maxLines: 2,
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BrandTexts.subTitleBold(
                      text: "${App.getPrice(model.product[index].price)}",
                      color: BrandColors.dark,
                    ),
                    BrandTexts.caption(
                      text: "${App.getTime(model.product[index].postAt)}",
                      color: BrandColors.dark,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: FadeInImage.memoryNetwork(
              width: 90.0,
              height: 90.0,
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
              image: (model.product[index].imageUrl != null && model.product[index].imageUrl.isNotEmpty)
                  ? model.product[index].imageUrl[0]
                  : NO_IMAGE,
            ),
          ),
        ],
      ),
    );
  }
}
