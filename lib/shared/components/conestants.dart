import 'package:honda_app/shared/network/local/cache_helper.dart';

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String? uId = CacheHelper.getData(key: 'uId');