import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_glossary/pages/new_page.dart';
import 'package:flutter_glossary/pages/wrap_page.dart';
import 'package:flutter_glossary/widgets/shimmer_item_loading.dart';
import 'package:http/http.dart' as http;
import 'package:quick_actions/quick_actions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // QuickActions quickActions = QuickActions();
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
          return _navigate(NewPage(
            title: shortcutType,
          ));
        case 'wrap_page':
          return _navigate(WrapPage(
            title: shortcutType,
          ));
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getAllTodos(),
        builder: (context, snapshot) {
          // WHILE THE CALL IS BEING MADE LOADING
          if (ConnectionState.active != null && !snapshot.hasData) {
            // return Center(child: CircularProgressIndicator());
            return ShimmerItemLoading();
          }

          // connectionState:ConnectionState (ConnectionState.waiting)
          // data:null
          // error:null
          // hasData:false
          // hasError:false

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
