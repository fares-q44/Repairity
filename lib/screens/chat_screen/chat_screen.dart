import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/chat.dart';
import 'package:repairity/widgets/top_notch.dart';
import 'components/chat_handler.dart';
import 'chatting_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<void> future;
  @override
  void initState() {
    // TODO: implement initState
    future =
        Provider.of<ChatHandler>(context, listen: false).fetchAndSetChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Chat> allChats = Provider.of<ChatHandler>(context).allChats;
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Column(
      children: [
        TopNotch(withBack: false, withAdd: false),
        FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  SizedBox(
                    height: sHeight * 0.35,
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: allChats.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      builder: (context, snapshot) => GestureDetector(
                        onTap: () {
                          //open the chatting screen with the selected user
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatPage(selectedChat: allChats[index]),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    SizedBox(width: 20.0),
                                    Text(
                                      ///couldn't get the user username!!
                                      'fetchedChats[index].secondPart',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        )
      ],
    );
  }
}
