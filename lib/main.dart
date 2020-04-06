import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ListViews',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('ListViews')),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget {
  @override
  BodyLayoutState createState() {
    return new BodyLayoutState();
  }
}

class BodyLayoutState extends State<BodyLayout> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> titles = ['Sun', 'Moon', 'Star'];

  @override
  Widget build(BuildContext context) {
    return _myListView();
  }

  Widget _myListView() {
    // the Expanded widget lets the columns share the space
    Widget column(int index) {
      return Expanded(
        child: InkWell(
          onTap: () {
            titles.insert(index, 'Inserted');
            _listKey.currentState.insertItem(index);
          },
          onLongPress: () {
            AnimatedListRemovedItemBuilder builder = (context, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Row(
                    children: <Widget>[
                      column(index),
                      column(index),
                    ],
                  ),
                ),
              );
            };

            _listKey.currentState.removeItem(index, builder);
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              // align the text to the left instead of centered
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  titles[index],
                  style: TextStyle(fontSize: 16),
                ),
                Text('subtitle'),
              ],
            ),
          ),
        ),
      );
    }

    // This is the animated row with the Card.
    Widget _buildItem(int index, Animation animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Row(
            children: <Widget>[
              column(index),
              column(index),
            ],
          ),
        ),
      );
    }

    return AnimatedList(
      key: _listKey,
      initialItemCount: titles.length,
      itemBuilder: (context, index, animation) {
        return _buildItem(index, animation);
      },
    );
  }
}
