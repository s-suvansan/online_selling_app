import '../../main_index.dart';

class CommonAppBar extends StatefulWidget {
  final String title;
  final bool isCenterTitle;
  final bool needDarkText;
  final bool isShowLike;
  final String docId;
  // final Function(bool) onLike;

  const CommonAppBar({
    Key key,
    this.title,
    this.isCenterTitle = true,
    this.needDarkText = false,
    this.isShowLike = false,
    this.docId,
    // this.onLike,
  }) : super(key: key);

  @override
  _CommonAppBarState createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  bool isLike = false;
  @override
  void initState() {
    super.initState();
    if (widget.isShowLike && widget.docId != "") {
      FireStoreService.isFavouriteProduct(docId: widget.docId).then((value) {
        setState(() {
          isLike = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          centerTitle: widget.isCenterTitle,
          backgroundColor: getIt<ThemeChange>().isDark ? BrandColors.dark1 : BrandColors.light,
          title: BrandTexts.titleBold(
            text: widget.title ?? "",
            color:
                getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark.withOpacity(widget.needDarkText ? 1.0 : 0.6),
            fontSize: 20.0,
          ),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 8.0,
          child: InkWell(
            onTap: () => App.popOnce(context),
            child: App.svgImage(svg: LEFT_ARROW_SVG, height: 24.0, color: BrandColors.brandColorDark),
          ),
        ),
        if (widget.isShowLike)
          Positioned(
            top: 0.0,
            bottom: 0.0,
            right: 8.0,
            child: InkWell(
              onTap: () => setLike(),
              child: App.svgImage(svg: isLike ? LIKE_FILL : LIKE, height: 24.0, color: BrandColors.brandColorDark),
            ),
          ),
      ],
    );
  }

  void setLike() {
    setLikeFirestore();
    setState(() {
      isLike = !isLike;
    });
    // widget.onLike(isLike);
  }

  // function for like and unlike in firebase
  void setLikeFirestore() {
    if (!isLike) {
      FireStoreService.favouriteProduct(docId: widget.docId);
    } else if (isLike) {
      FireStoreService.unFavouriteProduct(docId: widget.docId);
    }
  }
}
