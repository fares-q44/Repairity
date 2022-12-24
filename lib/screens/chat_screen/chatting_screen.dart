import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/massage.dart';
import 'package:repairity/widgets/top_notch.dart';
import 'package:repairity/models/chat.dart';
import 'components/massages_handler.dart';

//hold the text in the text field
final TextEditingController massageController = TextEditingController();

class Chatting extends StatelessWidget {
  //the chat that is entered now
  final Chat selectedChat;

  Chatting({super.key, required this.selectedChat});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: Column(
        children: [
          TopNotch(withBack: true, withAdd: false),
          FutureBuilder(
            //get all the massages for the selected chat
            future: Provider.of<MassagesHandler>(context, listen: false)
                .fetchAndSetMassages(selectedChat: selectedChat),
            builder: (context, snapshot) {
              //save all the massages in a list
              final List<Massage> fetchedMassages = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: fetchedMassages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      builder: (context, snapshot) => Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment:
                              //check if the massage is from the sender or receiver
                              //you have to change aliali to the current user Username
                              (fetchedMassages[index].senderId != "aliali"
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  //check if the massage is from the sender or receiver
                                  (fetchedMassages[index].senderId != "aliali"
                                      ? Colors.grey.shade200
                                      : Colors.blue[200]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              fetchedMassages[index].massageText,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          //the text field and the send button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: TextField(
                      controller: massageController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      //add the massage to the database
                      Provider.of<MassagesHandler>(context, listen: false)
                          .addMassage(
                              chatId: selectedChat.chatId,
                              senderId: selectedChat.firstPart,
                              massageText: massageController.text);
                    },
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
