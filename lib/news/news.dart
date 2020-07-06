import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: NewsBody(),
    );
  }
}

class NewsBody extends StatefulWidget {

  @override
  _NewsBodyState createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {

  Map newsData;

  fetchNews() async{
    http.Response response = await http.get('https://newsapi.org/v2/top-headlines?country=in&q=covid&apiKey=915a82ea89864f6e80eab6a08c381c87');
    setState(() {
      newsData = json.decode(response.body);
    });
  }

  @override

  void initState() { 
    super.initState();
    fetchNews();
  }
  Widget build(BuildContext context) {
    return newsData==null?Center(child: CircularProgressIndicator(),) : Container(
      padding: EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: newsData['totalResults'],
        itemBuilder: (context, index){
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: newsData==null? CircularProgressIndicator(): Image(
                    image: NetworkImage(newsData['articles'][index]['urlToImage']),
                  )
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    child: Text(
                      newsData['articles'][index]['title']
                    ),
                    onTap: () {
                      launch(newsData['articles'][index]['url']);
                    }
                  )
                )
              ],
            ),
          );
        }
      ),
    );
  }
}