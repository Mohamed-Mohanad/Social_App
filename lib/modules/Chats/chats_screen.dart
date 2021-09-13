import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honda_app/models/UserModel/userModel.dart';
import 'package:honda_app/modules/Chat_details/chat_details_screen.dart';
import 'package:honda_app/shared/bloc/cubit.dart';
import 'package:honda_app/shared/bloc/states.dart';
import 'package:honda_app/shared/components/compnents.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = AppCubit.get(context);
        return cubit.users.length > 0 ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildChatItem(cubit.users[index], context),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          itemCount: cubit.users.length,
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model,),);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  "${model.personalImage}",
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                "${model.name}",
                style: TextStyle(
                  height: 1.4,
                ),
              ),
            ],
          ),
    ),
  );
}
