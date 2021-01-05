import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glossary/ui/widgets/shimmer_item_loading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_glossary/ui/pages/new_page.dart';
import 'package:flutter_glossary/ui/pages/wrap_page.dart';
import 'package:quick_actions/quick_actions.dart';

class ListViewPage extends StatefulWidget {
  ListViewPage({Key key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final QuickActions quickActions = QuickActions();

  _navigate(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  Future getAllTodos() async {
    try {
      var response =
          await http.get('https://jsonplaceholder.typicode.com/todos');
      return json.decode(response.body);
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    _setupQuickActions();
    _handleQuickActions();
  }

  void _setupQuickActions() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: 'wrap_page',
        localizedTitle: 'Wrap Page',
      ),
      ShortcutItem(
        type: 'new_page',
        localizedTitle: 'New Page',
      ),
    ]);
  }

  void _handleQuickActions() {
    quickActions.initialize((String shortcutType) {
      switch (shortcutType) {
        case 'new_page':
          return _navigate(NewPage());
        case 'wrap_page':
          return _navigate(WrapPage());
        default:
          return MaterialPageRoute(builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No Page defined for $shortcutType'),
              ),
            );
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAllTodos(),
        builder: (context, snapshot) {
          
          // WHILE THE CALL IS BEING MADE LOADING
          if (ConnectionState.active != null && !snapshot.hasData) {
            // return Center(child: CircularProgressIndicator());
            return ShimmerItemLoading();
          }

          // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
          if (ConnectionState.done != null && snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          }
          // IF IT WORKS IT GOES HERE!
          return ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data[index]['title']),
                trailing: snapshot.data[index]['completed']
                    ? Icon(Icons.emoji_events, color: Color(0xffbF7B801))
                    : Icon(
                        Icons.campaign,
                        color: Color(0xffb55286F),
                      ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                indent: 20,
                endIndent: 20,
              );
            },
          );
        },
      ),
    );
  }
}
