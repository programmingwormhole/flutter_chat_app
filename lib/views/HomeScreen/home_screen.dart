import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_chat/components/navigate.dart';
import 'package:small_chat/components/shimmer_effect.dart';
import 'package:small_chat/controllers/chat_list_controller.dart';
import 'package:small_chat/core/services/shared_services.dart';
import 'package:small_chat/utils/colors.dart';
import 'package:small_chat/utils/config.dart';
import 'package:small_chat/utils/strings.dart';
import 'package:small_chat/views/ChatScreen/chat_screen.dart';

class HomeScreen extends GetView<ChatListController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appName,
          style: TextStyle(
            color: black,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: black.withOpacity(.1),
            backgroundImage: const NetworkImage(
              'https://www.pngkey.com/png/full/115-1150420_avatar-png-pic-male-avatar-icon-png.png',
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            tooltip: 'Log Out',
            onPressed: () {
              SharedServices().logOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: black.withOpacity(.060),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: writeSomething,
                        hintStyle: TextStyle(color: black.withOpacity(.5)),
                        prefixIcon: Icon(
                          Icons.search,
                          color: black.withOpacity(.5),
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Expanded(child: ShimmerEffect().chatListShimmer());
              } else {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.chatData.value!.length,
                  itemBuilder: (context, index) {
                    final data = controller.chatData.value![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InkWell(
                        onTap: () {
                          navigate(
                              context,
                              ChatScreen(
                                name: data.name!,
                                profilePicture: '$baseUrl/${data.image!}',
                                phone: data.phone!,
                                userID: data.userId.toString(),
                              ));
                        },
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage('$baseUrl/${data.image!}'),
                              ),
                              title: Text(
                                data.name!,
                                style: TextStyle(
                                  color: black.withOpacity(.8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                data.lastMessage!,
                                style: TextStyle(
                                  color: black.withOpacity(.4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
