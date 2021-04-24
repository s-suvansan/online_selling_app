import '../../main_index.dart';

class Empty extends StatelessWidget {
  final String image;
  final double size;
  final String text;
  final double moveFromTopBy;

  const Empty({
    Key key,
    this.image,
    this.size = 200.0,
    this.text = "Empty favourite list.",
    this.moveFromTopBy = 150.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      margin: EdgeInsets.only(top: moveFromTopBy),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: BrandColors.light,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Lottie.asset(
                image ?? EMPTY_HEART,
                width: size,
                height: size,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          BrandTexts.titleBold(
            text: "Empty favourite list.",
            fontSize: 18.0,
            fontWeight: BrandTexts.black,
          )
        ],
      ),
    );
  }
}
