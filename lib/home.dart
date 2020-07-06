import 'package:flutter/material.dart';
import 'Home/appbar.dart';
import 'Home/statsList.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; 
    height = 0.55*height;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: height,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(child: Icon(Icons.blur_circular),),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text('Covid19-Tracker')
                    )
                )
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: HomeAppbar(),
            ),
          ),
          // If the main content is a list, use SliverList instead.
          // SliverFillRemaining(
          //   child: StatList()
          // ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                // Container(
                //   padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                //   child: Text(
                //     'India Statistic',
                //     style: TextStyle(
                //       color: Colors.lightBlue[900],
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold
                //     ),
                //   ),
                // ),
                StatList()
              ]
            )
          )
        ],
      ),
    );
  }
}