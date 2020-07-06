import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeAppbar extends StatefulWidget {
  @override
  _HomeAppbarState createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
  
  bool toggleValue = true;
  Map worldData;

  fetchworlData() async{
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  Map countryData;

  fetchCountryData() async{
    http.Response response = await http.get('https://api.rootnet.in/covid19-in/stats');
    setState(() {
      countryData = json.decode(response.body);

    });
  }

  @override

  void initState() { 
    fetchworlData();
    fetchCountryData();
    super.initState();

   }
  Widget build(BuildContext context) {

    double appBarHeight = 0.5*MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return countryData==null ? Center(child: CircularProgressIndicator()):Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      child: Column(  
        mainAxisAlignment: MainAxisAlignment.end,    
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Statistics',
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Playfair Display',
                ),
              ),
            ),
          ),

          Container(
            width: 0.8*width,
            height: 50.0,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            decoration: BoxDecoration(
              color: Colors.blue[100].withOpacity(0.5),
              borderRadius: BorderRadius.circular(30)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    setState(() {
                      toggleValue = !toggleValue; 
                    });
                  },
                  child: Container(
                    height: 40,
                    width: toggleValue ? 0.4*width:0.35*width,
                    decoration: BoxDecoration(
                      color: toggleValue ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'MyCountry',
                          style: TextStyle(
                            fontSize: toggleValue? 16.0 : 15.0,
                            color:  toggleValue? Colors.lightBlue[700] : Colors.white
                          ),
                        ),
                      )
                    ),
                  ),
                ),
                
                GestureDetector(
                  onTap: (){
                    setState(() {
                      toggleValue = !toggleValue; 
                    });
                  },
                  child: Container(
                    height: 40,
                    width: toggleValue ? 0.35*width: 0.4*width,
                    decoration: BoxDecoration(
                      color: toggleValue ? Colors.transparent : Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'World',
                          style: TextStyle(
                            fontSize: toggleValue? 15.0 : 16.0 ,
                            color:  toggleValue? Colors.white :  Colors.lightBlue[700] 
                          ),
                        ),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
              children: <Widget>[
                StatusPanel(title: 'CONFIRMED',panelColor: Colors.cyan.withOpacity(0.8), count: toggleValue? countryData['data']['unofficial-summary'][0]['total']:worldData['cases']),
                StatusPanel(title: 'ACTIVE',panelColor: Colors.yellow[600].withOpacity(0.8), count: toggleValue? countryData['data']['unofficial-summary'][0]['active']:worldData['active']),
                StatusPanel(title: 'RECOVERED',panelColor: Colors.greenAccent[400].withOpacity(0.8), count: toggleValue? countryData['data']['unofficial-summary'][0]['recovered']:worldData['recovered'] ),
                StatusPanel(title: 'DEATHS',panelColor: Colors.redAccent.withOpacity(0.8), count: toggleValue? countryData['data']['unofficial-summary'][0]['deaths']:worldData['deaths'],)
              ],
            ),
          ),

          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final String title;
  final Color panelColor;
  final int count;

  const StatusPanel({Key key, this.title, this.panelColor, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(7),
      width: 0.5*width,
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}