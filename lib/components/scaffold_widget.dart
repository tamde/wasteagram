import 'package:flutter/material.dart';


class ScaffoldWidget extends StatelessWidget {
  final String title;
  final child;
  final body;
  final floatingActionButton;
  final darkTheme;
  final toggleTheme;

  ScaffoldWidget({this.title = '', this.body, this.child, this.floatingActionButton, this.darkTheme, this.toggleTheme});
  
  // flutter cookbook
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(this.title),
      ),
      // endDrawer: ThemeToggle(darkTheme: darkTheme, toggleTheme: toggleTheme),
      body: this.body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: this.floatingActionButton
      
    );
  }
}

class ThemeToggle extends StatefulWidget {

  final darkTheme;
  final toggleTheme;

  ThemeToggle({Key key, this.darkTheme, this.toggleTheme}) : super(key: key);

  @override
  _ThemeToggleState createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  
  bool lights = false;
  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
          child: Text('header'),
          ),
          SwitchListTile(
            title: Text('toggle theme'),
            value: widget.darkTheme,
            onChanged: widget.toggleTheme,
          )
        ]  
      )  
    );
  }
}