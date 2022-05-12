import 'dart:async';

import 'package:online_shop/main_index.dart';

class ChatViewModel extends BaseViewModel {
  //variables
  String _message = "";

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  List<MessageModel> _messageList = [];
  List<MessageModel> get messageList => _messageList;

  Timestamp _chatStartDate;
  Timestamp get chatStartDate => _chatStartDate;
  set setChatStartDate(Timestamp chatStartDate) => _chatStartDate = chatStartDate;

  void getChatList(AsyncSnapshot<DocumentSnapshot> snapshot) {
    // print(snapshot);
    try {
      if (snapshot.hasData && snapshot?.data?.data() != null && snapshot.data.data().length >= 0) {
        // var data = snapshot.data;
        List<MessageModel> _msgList = [];
        snapshot.data.data().forEach((key, value) {
          // MessageModel _msg = MessageModel.fromJson(value);
          _msgList.add(MessageModel.fromJson(value));
        });
        _messageList = _msgList;
        _messageList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        if (_messageList != null && _messageList.isNotEmpty) {
          _chatStartDate = _messageList[0].dateTime;
        }
      }
      // _messageList = List<MessageModel>.from(snapshot.data.data.map((key, value) => MessageModel.fromJson(value)));
    } catch (e) {
      print(e.toString());
    }
  }

  bool _isTyping = false;
  final _debouncer = Debouncer(milliseconds: 2000);

  void onMessageType(String msg) {
    _message = msg;

    if (msg.isNotEmpty && !_isTyping) {
      _isTyping = true;
      FireChatService.setIsTyping(_isTyping);
    }

    _debouncer.run(
      () {
        if (_isTyping) {
          _isTyping = false;
          FireChatService.setIsTyping(_isTyping);
          print(msg);
        }
      },
    );
  }

  void onSendMessage() {
    if (_message != null && _message != "") {
      FireChatService.sentMessage(MessageModel(message: _message)).then((value) {
        if (value) {
          if (_isTyping) {
            _isTyping = false;
            FireChatService.setIsTyping(_isTyping);
          }
          _message = "";
          _textEditingController.clear();
        }
      });
    }
  }

  bool canShowDate(int index) {
    try {
      var _nextIndex = (index + 1) < _messageList.length ? (index + 1) : _messageList.length - 1;
      if (_messageList[index].dateTime.toDate().day != _messageList[_nextIndex].dateTime.toDate().day ||
          index == _messageList.length - 1) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

class MessageModel {
  final String message;
  final String repliedMessage;
  final bool isCustomer;
  final Timestamp dateTime;
  final List<dynamic> images;

  MessageModel({this.message, this.repliedMessage, this.isCustomer, this.dateTime, this.images});

  factory MessageModel.fromJson(Map<dynamic, dynamic> json) => MessageModel(
        message: json["message"] ?? "",
        repliedMessage: json["repliedMessage"] ?? "",
        isCustomer: json["isCustomer"] ?? false,
        dateTime: json["dateTime"],
        images: json["images"] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "message": message ?? "",
        "repliedMessage": repliedMessage ?? "",
        "isCustomer": true,
        "dateTime": Timestamp.now(),
        "images": images ?? [],
      };
}

class ChatListModel {
  final String userId;
  final String userName;
  final String userImage;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final bool isLastMessageImage;

  ChatListModel({this.userId, this.userName, this.userImage, this.lastMessage, this.lastMessageTime, this.isLastMessageImage});

  factory ChatListModel.fromJson(Map<dynamic, dynamic> json) => ChatListModel(
        userId: json["userId"] ?? "",
        userName: json["userName"] ?? "",
        userImage: json["userImage"] ?? "",
        lastMessage: json["lastMessage"] ?? "",
        lastMessageTime: json["lastMessageTime"] ?? Timestamp.now(),
        isLastMessageImage: json["isLastMessageImage"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId ?? "${Global.userInfo.uid}",
        "userName": userName ?? "${Global.userInfo.uid}",
        "userImage": userImage ?? "",
        "lastMessage": lastMessage,
        "lastMessageTime": lastMessageTime,
        "isLastMessageImage": isLastMessageImage,
      };
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }
}
