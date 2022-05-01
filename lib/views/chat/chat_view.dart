import '../../main_index.dart';

class ChatView extends StatelessWidget {
  static const String routeName = "chatview";
  const ChatView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _msgTileWidth = App.getDeviceWidth(context) - 100.0;
    return ViewModelBuilder<ChatViewModel>.nonReactive(
      builder: (context, model, _) => Scaffold(
        backgroundColor: BrandColors.shadowLight,
        appBar: _AppBar(),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                      reverse: true,
                      padding: EdgeInsets.fromLTRB(8, 12, 8, 8),
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: index.isEven ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                constraints: BoxConstraints(maxWidth: _msgTileWidth),
                                decoration: BoxDecoration(
                                  color: index.isEven ? BrandColors.brandColorLight : BrandColors.light,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(index.isEven ? 12.0 : 0.0),
                                    topRight: Radius.circular(12.0),
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(index.isEven ? 0.0 : 12.0),
                                  ),
                                ),
                                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                // margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                            child: BrandTexts.commonText(text: "Message  $index", fontSize: 14.0, maxLines: 8)),
                                        SizedBox(width: 8.0),
                                        BrandTexts.caption(text: "11:24 AM", fontSize: 10.0)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (ctx, i) => SizedBox(height: 8.0),
                      itemCount: 25)),
              _MessageBox(),
            ],
          ),
        ),
        // floatingActionButton: _MessageBox(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
      viewModelBuilder: () => ChatViewModel(),
    );
  }
}

//app bar
class _AppBar extends ViewModelWidget<ChatViewModel> implements PreferredSizeWidget {
  const _AppBar({Key key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return CommonAppBar(
      title: "Chat",
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MessageBox extends ViewModelWidget<ChatViewModel> {
  const _MessageBox({Key key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, ChatViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 2, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: BrandColors.light,
                    borderRadius: BorderRadius.circular(32.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                        color: BrandColors.shadow.withOpacity(0.4),
                        offset: Offset(0.0, 1.0),
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Message",
                      border: InputBorder.none,
                    ),
                    maxLines: 4,
                    minLines: 1,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: BrandColors.light,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                      color: BrandColors.shadow.withOpacity(0.4),
                      offset: Offset(0.0, 1.0),
                    )
                  ],
                ),
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.send),
              )
            ],
          ),
        ),
      ],
    );
  }
}
