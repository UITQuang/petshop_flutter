import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class Conversation extends StatefulWidget {
  const Conversation({Key? key}) : super(key: key);

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  var box = Hive.box('userBox');
  static const String SECOND_USER_ID = "0"; //

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final _messageController = TextEditingController();

  String _apiKey = '4541cb3c2da572886efd';
  String _cluster = 'ap1';
  String _channelName = 'channel-demo-real-time';
  List listMesage = [
    // ChatMessage(text: "hello peter", isSender: true,),
    // ChatMessage(text: "hi john", isSender: false,),
    // ChatMessage(text: "how are you?", isSender: true,),
    // ChatMessage(text: "I'm fine", isSender: false,),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage(user_id: box.get("id").toString(), second_user_id: SECOND_USER_ID);
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      pusher.init(
        apiKey: _apiKey,
        cluster: _cluster,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
      );
      await pusher.subscribe(channelName: _channelName);
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void onEvent(PusherEvent event) {
    var data = jsonDecode(event.data.toString());
    if (data["sender_id"] != null &&
        data["sender_id"] == "0" &&
        data["recive_id"].toString() == box.get("id").toString()) {
      setState(() {
        listMesage.add(ChatMessage(text: data["message"], isSender: false));
      });
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("Kết nối Pusher thành công!");
  }

  Future<void> createMessage(
      {required String user_id,
      required String second_user_id,
      required String message,
      required String sender_name}) async {
    Map<String, String> body = {
      'user_id': user_id,
      'second_user_id': second_user_id,
      'message': message,
      'sender_name': sender_name,
    };
    http.Response response = await http.post(
        Uri.parse("https://meowmeowpetshop.xyz/api/v1/create-message"),
        body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<void> getMessage(
      {required String user_id, required String second_user_id}) async {
    Map<String, String> body = {
      'user_id': user_id,
      'second_user_id': second_user_id,
    };
    http.Response response = await http.post(
        Uri.parse("https://meowmeowpetshop.xyz/api/v1/get-conversation"),
        body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (var item in data["messages"]) {

        item["isSender"] == 0
            ? listMesage.add(ChatMessage(text: item["text"], isSender: false))
            : listMesage.add(ChatMessage(text: item["text"], isSender: true));
      }
      setState(() {});
    } else {
      throw Exception('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pusher.disconnect();
        print("Huỷ kết nối Pusher");
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.jpg"),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Meow Meow PetShop",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.local_phone))
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child:  ListView.builder(
                    itemCount: listMesage.length,
                    itemBuilder: (context, index) {
                      if(listMesage.length != 0 && listMesage.length != null)
                        return _messages(listMesage[index]);
                      else{
                        return Center(child: Text("chưa có tin nhắn"),);
                      }
                    })
            ),
              _chatInputField(),
            ],
          )),
    );
  }


  Widget _chatInputField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 32,
                color: Color(0xFF087949).withOpacity(0.2))
          ]),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.image),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(40)),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                        hintText: "Type message", border: InputBorder.none),
                  )),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        createMessage(
                            user_id: box.get("id").toString(),
                            second_user_id: SECOND_USER_ID,
                            message: _messageController.text,
                            sender_name: box.get("name").toString());
                        listMesage.add(ChatMessage(
                            text: _messageController.text, isSender: true));
                      });
                      _messageController.text = "";
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _messages(message) {
    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(message.isSender ? 1 : 0.5),
              borderRadius: BorderRadius.circular(30)),
          child: Text(message.text),
        )
      ],
    );
  }
}

class ChatMessage {
  final String text;
  final bool isSender;

  ChatMessage({
    required this.text,
    required this.isSender,
  });

  ChatMessage.fromJson(Map json)
      : text = json['message'],
        isSender = json['isSender'];
}
