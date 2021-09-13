import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honda_app/models/MessageModel/message_model.dart';
import 'package:honda_app/models/UserModel/userModel.dart';
import 'package:honda_app/shared/bloc/cubit.dart';
import 'package:honda_app/shared/bloc/states.dart';
import 'package:honda_app/shared/styles/colors.dart';
import 'package:honda_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatDetailsScreen({
    required this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).getMessages(
          receiverId: userModel.uId.toString(),
        );

        return BlocConsumer<AppCubit, States>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel.personalImage.toString(),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        userModel.name.toString(),
                      ),
                    )
                  ],
                ),
              ),
              body: cubit.messages.length > 0
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var message = cubit.messages[index];
                                  if (cubit.userModel!.uId ==
                                      message.senderId) {
                                    return buildSenderMessage(message);
                                  }
                                  return buildReceiverMessage(message);
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 15.0,
                                    ),
                                itemCount: cubit.messages.length),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type a message',
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  color: defaultColor,
                                  child: MaterialButton(
                                    minWidth: 1.0,
                                    onPressed: () {
                                      cubit.sendMessage(
                                        receiverId: userModel.uId.toString(),
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                      );
                                    },
                                    child: Icon(
                                      IconBroken.Send,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Messages Between You and This Person",
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(
                                15.0,
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type a message',
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  color: defaultColor,
                                  child: MaterialButton(
                                    minWidth: 1.0,
                                    onPressed: () {
                                      cubit.sendMessage(
                                        receiverId: userModel.uId.toString(),
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                      );
                                    },
                                    child: Icon(
                                      IconBroken.Send,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }

  Widget buildReceiverMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );
  Widget buildSenderMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(
              0.2,
            ),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );
}
