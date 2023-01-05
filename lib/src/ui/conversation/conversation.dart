import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:project1/src/services/utilities/colors.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Conversation extends StatefulWidget {
  const Conversation({Key? key}) : super(key: key);

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  var box = Hive.box('userBox');
  static const String SECOND_USER_ID = "0"; //

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  TextEditingController _messageController = TextEditingController();
  ScrollController focusBottom = ScrollController();
  bool enableSend = false;

  String _apiKey = '4541cb3c2da572886efd';
  String _cluster = 'ap1';
  String _channelName = 'channel-demo-real-time';
  List listMessage = [
    // ChatMessage(text: "hello peter", isSender: true,),
    // ChatMessage(text: "hi john", isSender: false,),
    // ChatMessage(text: "how are you?", isSender: true,),
    // ChatMessage(text: "I'm fine", isSender: false,),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage(
        user_id: box.get("id").toString(), second_user_id: SECOND_USER_ID);
    initPlatformState();
    _messageController.addListener(() {
      final enableSend = _messageController.text.isNotEmpty;
      if (enableSend == true) {
        setState(() {
          this.enableSend = true;
        });
      } else {
        setState(() {
          this.enableSend = false;
        });
      }
    });
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
        listMessage.add(ChatMessage(text: data["message"], isSender: false));
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
            ? listMessage.add(ChatMessage(text: item["text"], isSender: false))
            : listMessage.add(ChatMessage(text: item["text"], isSender: true));
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
            backgroundColor: PRIMARY_COLOR,
            title: Row(
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.jpg"),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Meow Meow PetShop",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    launch('tel://0853685806');
                  },
                  icon: const Icon(Icons.local_phone))
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                controller: focusBottom,
                itemCount: listMessage.length,
                itemBuilder: (context, index) {
                  if (listMessage.isNotEmpty) {
                    return _messages(listMessage[index]);
                  } else {
                    return const Center(
                      child: Text("chưa có tin nhắn"),
                    );
                  }
                },
              )),
              _chatInputField(),
            ],
          )),
    );
  }

  Widget _chatInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 32,
                color: const Color(0xFF087949).withOpacity(0.2))
          ]),
      child: SafeArea(
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(40)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                        hintText: "Type message", border: InputBorder.none),
                  )),
                  IconButton(
                    onPressed: (enableSend)
                        ? () {
                            setState(() {
                              createMessage(
                                  user_id: box.get("id").toString(),
                                  second_user_id: SECOND_USER_ID,
                                  message: _messageController.text,
                                  sender_name: box.get("name").toString());
                              listMessage.add(ChatMessage(
                                  text: _messageController.text,
                                  isSender: true));
                              focusBottom.jumpTo(
                                focusBottom.position.maxScrollExtent,
                              );
                            });
                            _messageController.clear();
                          }
                        : null,
                    icon: const Icon(
                      Icons.send,
                      color: PRIMARY_COLOR,
                    ),
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
    print(MediaQuery.of(context).size.width*0.6);
    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width*0.6,
            minWidth: MediaQuery.of(context).size.width*0.3,
          ),
          width: message.text.length*8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent
                  .withOpacity(message.isSender ? 1 : 0.5),
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
