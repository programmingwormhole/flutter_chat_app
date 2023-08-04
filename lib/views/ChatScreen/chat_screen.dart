
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:small_chat/components/snack_bar.dart';
import 'package:small_chat/controllers/send_message_controller.dart';
import 'package:small_chat/controllers/user_messages_controller.dart';
import 'package:small_chat/utils/colors.dart';
import 'package:small_chat/utils/strings.dart';
import 'package:small_chat/views/ChatScreen/widgets/single_message_widget.dart';

import '../../components/shimmer_effect.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String profilePicture;
  final String phone;
  final String userID;

  const ChatScreen({
    super.key,
    required this.name,
    required this.profilePicture,
    required this.phone,
    required this.userID,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = Get.put(UserMessagesController());
  String myID = '';
  final sendController = Get.put(SendMessageController());

  late ScrollController _scrollController;

  getMyId() async {
    final pref = await SharedPreferences.getInstance();
    final id = pref.getString('id');
    setState(() {
      myID = id!;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.getData(userID: widget.userID);
    getMyId();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.profilePicture),
                ),
                title: Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  widget.phone,
                  style: TextStyle(color: black.withOpacity(.5)),
                ),
              ),
            )
          ],
        ),
        actions: const [
          Icon(Icons.call),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.videocam_rounded,
            size: 28,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return Expanded(child: ShimmerEffect().messageLoadShimmer(size));
            } else {
              return Expanded(
                  child: ListView.builder(
                itemCount: controller.chatData.value!.length,
                shrinkWrap: true,
                primary: false,
                // reverse: true,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  final data = controller.chatData.value![index];
                  return data.userId.toString() == myID
                      ? SingleMessageWidget(
                          isMe: true,
                          backgroundColor: primary,
                          alignment: CrossAxisAlignment.end,
                          data: data,
                        )
                      : SingleMessageWidget(
                          backgroundColor: black.withOpacity(.5),
                          alignment: CrossAxisAlignment.start,
                          data: data,
                        );
                },
              ));
            }
          }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    width: size.width * .9,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: SizedBox(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Type a message...';
                                  }
                                  return null;
                                },
                                maxLines: 5,
                                minLines: 1,
                                controller: sendController.messageDataController,
                                keyboardType: TextInputType.multiline,
                                style: const TextStyle(color: black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: writeSomething,
                                  hintStyle: TextStyle(
                                    color: black.withOpacity(.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Obx(() {
                  if (sendController.isLoading.value) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: white,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () async {
                        if (sendController.messageDataController.text.isEmpty) {
                          snackBar(
                            context: context,
                            message: writeSomething,
                          );
                        } else {
                          await sendController.sendResponse(
                            userID: widget.userID,
                            message: sendController.messageDataController.text,
                          );
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Icon(
                              Icons.send,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                })
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
