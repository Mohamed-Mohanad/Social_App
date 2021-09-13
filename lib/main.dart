import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honda_app/modules/Home/home_screen.dart';
import 'package:honda_app/modules/Login/login_screen.dart';
import 'package:honda_app/shared/bloc/bloc_observer.dart';
import 'package:honda_app/shared/bloc/cubit.dart';
import 'package:honda_app/shared/bloc/states.dart';
import 'package:honda_app/shared/components/compnents.dart';
import 'package:honda_app/shared/components/conestants.dart';
import 'package:honda_app/shared/network/local/cache_helper.dart';
import 'package:honda_app/shared/styles/themes.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());

  showToast(text: 'on background message', state: ToastStates.SUCCESS);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());

    showToast(text: 'on message', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());

    showToast(text: 'on message opened app', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  Widget widget;

  uId = CacheHelper.getData(key: 'uId');

  if(uId != null){
    widget = HomeScreen();
  }else{
    widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData()..getPosts(),
      child: BlocConsumer<AppCubit, States>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            title: 'Social',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}

