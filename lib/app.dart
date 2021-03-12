import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/list_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/new_post_screen.dart';


class App extends StatefulWidget {
  final schema;
  final SharedPreferences preferences;
  // final journalEntry = JournalEntry();
  App({this.schema, this.preferences});
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // static const darkThemeKey = 'darkTheme';

  // // shared preferences
  // bool get darkTheme => widget.preferences.getBool(darkThemeKey) ?? false;
  // void toggleTheme (bool value){
  //   setState((){
  //     widget.preferences.setBool(darkThemeKey, !darkTheme);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // var length = getEntries.length;
    var routes = {
      // Welcome.routeName: (context) => Welcome(darkTheme: darkTheme, toggleTheme: toggleTheme,),
      PostLists.routeName: (context) => PostLists(schema: widget.schema,),
      Details.routeName: (context) => Details(),
      NewPost.routeName: (context) => NewPost()
      // JournalEntryList.routeName: (context) => JournalEntryList(darkTheme: darkTheme, toggleTheme: toggleTheme, schema: widget.schema,),
      // EntryScreen.routeName: (context) => EntryScreen(darkTheme: darkTheme, toggleTheme: toggleTheme)

    };
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      // theme: darkTheme ? ThemeData.dark() : ThemeData.light(),
      initialRoute: PostLists.routeName,
      routes: routes,
    );
  }
}
