import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/chat.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import '../../main.dart';
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Chats'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const MyApp(),
                ),
                (_) => false,
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
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
                if (allChats.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        future =
                            Provider.of<ChatHandler>(context, listen: false)
                                .fetchAndSetChats();
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        SizedBox(height: sHeight * 0.8, child: ListView()),
                        Positioned(
                            bottom: sHeight * 0.4,
                            left: sWidth * 0.36,
                            child: const Text('You have no chats'))
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      future = Provider.of<ChatHandler>(context, listen: false)
                          .fetchAndSetChats();
                    });
                  },
                  child: SizedBox(
                    height: sHeight * 0.8,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 20.0),
                                        Text(
                                          allChats[index].secondPartUsername,
                                          style: const TextStyle(fontSize: 20),
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
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
