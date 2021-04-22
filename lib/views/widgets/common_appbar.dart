import '../../main_index.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenterTitle;
  final bool needDarkText;

  const CommonAppBar({Key key, this.title, this.isCenterTitle = true, this.needDarkText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          // automaticallyImplyLeading: false,
          centerTitle: isCenterTitle,
          backgroundColor: BrandColors.light,
          title: BrandTexts.titleBold(
            text: title ?? "",
            color: BrandColors.dark.withOpacity(needDarkText ? 1.0 : 0.6),
            fontSize: 20.0,
          ),

          // leading: ,
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 8.0,
          child: InkWell(
            onTap: () => App.popOnce(context),
            child: App.svgImage(svg: LEFT_ARROW_SVG, height: 24.0, color: BrandColors.brandColorDark
                // width: 20.0,
                ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
