import 'dart:convert';
import 'package:covid19_tracker/districtPage/districtStats.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatList extends StatefulWidget {
  @override
  _StatListState createState() => _StatListState();
}

class _StatListState extends State<StatList> {

  Map countryData;

  fetchCountryData() async{
    http.Response response = await http.get('https://api.covid19india.org/data.json');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override

  void initState() { 
    super.initState();
    fetchCountryData();
  }

  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;

    return countryData==null ? Center(child: Text(''),):ListView.builder(
      padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index){
        
        return Container(
          height: 130,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(
              color: Colors.grey[100],
              blurRadius: 10,
              offset: Offset(0,5),
              spreadRadius: 5
            )]
          ),
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DistrictPage(stateCode: countryData['statewise'][index+1]['state'],)));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: Container(
                            child: Text(
                              countryData['statewise'][index+1]['state'].toString(),
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.lightBlue[900]
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey[600],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //Confirmed cases
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Confirmed',
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Colors.cyan
                            ),
                          ),
                          Text(
                             countryData['statewise'][index+1]['confirmed'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500]
                            ),
                          ),
                        ],
                      ),
                      //Active cases
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: <Widget>[
                      //     Text(
                      //       'C',
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.cyan
                      //       ),
                      //     ),
                      //     Text(
                      //       countryData['data']['regional'][index]['totalConfirmed'].toString(),
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         color: Colors.grey[500]
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //recovered cases
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Recovered',
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Colors.blue
                            ),
                          ),
                          Text(
                            countryData['statewise'][index+1]['recovered'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500]
                            ),
                          ),
                        ],
                      ),
                      //death cases
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Deaths',
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                              color: Colors.red
                            ),
                          ),
                          Text(
                            countryData['statewise'][index+1]['deaths'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500]
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: countryData==null ? 0:countryData['statewise'].length-1,
    );
  }
}