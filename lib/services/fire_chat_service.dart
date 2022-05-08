import '../main_index.dart';

class FireChatService {
  // get chat snapshot for stream build
  static Stream<DocumentSnapshot> getChats() {
    return Firestore.instance.collection(Global.CHAT_ROOM).document(Global.userInfo.uid).snapshots();
  }

  //sent Message
  static Future<bool> sentMessage(MessageModel data) async {
    // Call the user's CollectionReference to add a new user
    try {
      await Firestore.instance
          .collection(Global.CHAT_ROOM)
          .document(Global.userInfo.uid)
          .setData({"${Timestamp.now().toDate()}": data.toJson()}, merge: true);
      var _data = data.toJson();
      await setUserChatInfo(
        ChatListModel(
          lastMessage: _data["message"],
          lastMessageTime: _data["dateTime"],
          isLastMessageImage: _data["images"].isNotEmpty,
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  //sent Message
  static Future<bool> setUserChatInfo(ChatListModel data) async {
    // Call the user's CollectionReference to add a new user
    try {
      await Firestore.instance.collection(Global.CHAT_LIST).document(Global.userInfo.uid).setData(data.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<DocumentSnapshot> getIsTyping() {
    return Firestore.instance
        .collection(Global.CHAT_ROOM)
        .document(Global.userInfo.uid)
        .collection("realtime_typing")
        .document("typing")
        .snapshots();
  }

  //sent Message
  static Future<void> setIsTyping(bool val) async {
    // Call the user's CollectionReference to add a new user
    try {
      await Firestore.instance
          .collection(Global.CHAT_ROOM)
          .document(Global.userInfo.uid)
          .collection("realtime_typing")
          .document("typing")
          .setData({"isUserTyping": val}, merge: true);
      // return true;
    } catch (e) {
      // return false;
      print(e.toString());
    }
  }
}
