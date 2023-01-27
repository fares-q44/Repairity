import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/chat.dart';
import 'package:repairity/widgets/top_notch.dart';
import 'components/chat_handler.dart';
import 'chatting_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Column(
      children: [
        TopNotch(withBack: false, withAdd: false),
        FutureBuilder(
          future: Provider.of<ChatHandler>(context, listen: false)
              .fetchAndSetChats(),
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
              final List<Chat> fetchedChats = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: fetchedChats.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      builder: (context, snapshot) => GestureDetector(
                        onTap: () {
                          //open the chatting screen with the selected user
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatPage(selectedChat: fetchedChats[index]),
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
                                  children: [
                                    SizedBox(width: 20.0),
                                    Text(
                                      ///couldn't get the user username!!
                                      Provider.of<ChatHandler>(context,
                                              listen: false)
                                          .getUsername(
                                              fetchedChats[index].secondPart)
                                          .toString(),
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
