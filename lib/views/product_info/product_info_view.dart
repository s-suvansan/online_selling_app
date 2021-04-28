import '../../main_index.dart';

class ProductInfoView extends StatelessWidget {
  final ProductModel productModel;
  const ProductInfoView({Key key, @required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductInfoViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: BrandColors.light,
        appBar: CommonAppBar(
          title: "Product Info",
        ),
        body: Container(
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              _TopImagesView(),
              _ContentView(),
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
        color: BrandColors.shadowLight,
        child: Stack(
          children: [
            PageView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: model.product.imageUrl?.length,
              itemBuilder: (context, index) {
                return Image.network(
                  model.product.imageUrl[index],
                  fit: BoxFit.contain,
                );
              },
            ),
            Positioned(
              top: 0,
              bottom: 0,
              child: Container(
                height: 40.0,
                width: 20.0,
                decoration: BoxDecoration(
                    color: BrandColors.light,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    )),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20.0,
                  color: BrandColors.shadow,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                height: 40.0,
                width: 20.0,
                decoration: BoxDecoration(
                    color: BrandColors.light,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                    )),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20.0,
                  color: BrandColors.shadow,
                ),
              ),
            )
          ],
        ));
  }
}

class _ContentView extends ViewModelWidget<ProductInfoViewModel> {
  @override
  Widget build(BuildContext context, ProductInfoViewModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      width: App.getDeviceWidth(context),
      color: BrandColors.light,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          BrandTexts.commonText(
              text: "${model.product.title}",
              fontSize: 24.0,
              fontWeight: BrandTexts.bold,
              maxLines: 3,
              color: BrandColors.shadowDark),
          SizedBox(height: 8.0),
          // posted time
          BrandTexts.caption(
            text: "Posted at ${App.showDateTimeInFormat(model.product.postAt, format: DateTimeFormat.DateAndTime)}",
            color: BrandColors.shadowDark,
          ),
          if (model.product.postBy != "") SizedBox(height: 8.0),
          // posted by
          if (model.product.postBy != "")
            Row(
              children: [
                BrandTexts.caption(
                  text: "Posted by ${model.product.postBy}",
                  color: BrandColors.shadowDark,
                ),
                BrandTexts.caption(
                  text: ", ${model.product.postFrom} ",
                  color: BrandColors.shadowDark,
                ),
              ],
            ),

          SizedBox(height: 16.0),
          Divider(height: 0.0, color: BrandColors.shadowDark),
          SizedBox(height: 8.0),
          //price
          Row(
            children: [
              App.svgImage(svg: PRICE_TAG, height: 28.0, color: BrandColors.brandColorDark),
              SizedBox(width: 8.0),
              BrandTexts.commonText(
                text: "${App.getPrice(model.product.price)}",
                fontSize: 20.0,
                fontWeight: BrandTexts.black,
                color: BrandColors.shadowDark,
                maxLines: 3,
              ),
              SizedBox(width: 8.0),
              if (model.product.isNegotiable)
                BrandTexts.subTitleBold(
                  text: "Negotiable",
                  fontStyle: FontStyle.italic,
                  color: BrandColors.shadow,
                )
            ],
          ),
          SizedBox(height: 8.0),
          Divider(height: 0.0, color: BrandColors.shadowDark),
          SizedBox(height: 16.0),
          if (model.product.desc != "")
            LayoutBuilder(builder: (context, size) {
              // for find the maxline of desc
              final span = TextSpan(text: model.product.desc);
              final tp = TextPainter(text: span, maxLines: 5, textDirection: TextDirection.ltr);
              tp.layout(maxWidth: size.maxWidth);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandTexts.titleBold(
                    text: "Description",
                    color: BrandColors.dark,
                  ),
                  SizedBox(height: 8.0),
                  //description
                  BrandTexts.titleBold(
                    text: "${model.product.desc} ",
                    color: BrandColors.shadowDark,
                    textAlign: TextAlign.justify,
                    maxLines: model.showMore ? 100 : 5,
                  ),
                  SizedBox(height: 8.0),
                  // show more and show less button
                  if (tp.didExceedMaxLines)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => model.showMoreDesc(),
                          child: Container(
                            padding: EdgeInsets.only(right: 8.0, left: 2.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: BrandColors.shadowLight,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: BrandColors.shadow,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  model.showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                  color: BrandColors.shadow,
                                  size: 26.0,
                                ),
                                BrandTexts.subTitleBold(
                                  text: model.showMore ? "Show less" : "Show more",
                                  color: BrandColors.shadow,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              );
            }),
        ],
      ),
    );
  }
}
