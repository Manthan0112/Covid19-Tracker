import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistrictPage extends StatelessWidget {

  final String stateCode ;

  const DistrictPage({Key key, this.stateCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 6,
        title: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(stateCode + ' Statistics')
            )
        ),
      ),
      body: DistrictStats(stateCode: stateCode,)
    );
  }
}

class DistrictStats extends StatefulWidget {

  final String stateCode;

  const DistrictStats({Key key, this.stateCode}) : super(key: key);

  @override
  _DistrictStatsState createState() => _DistrictStatsState(stateCode, 0);
}

class _DistrictStatsState extends State<DistrictStats> {

  final String stateCode1;

  int index2;
  
  List districtData;

  _DistrictStatsState( this.stateCode1, this.index2);

  fetchDistrictData() async{
    http.Response response = await http.get('https://api.covid19india.org/v2/state_district_wise.json');
    setState(() {
      districtData = json.decode(response.body);
      for (var i = 0; i < districtData.length; i++) {
        if(districtData[i]['state']==stateCode1){
          index2 = i;
        }
      }
    });
  }


  @override

  void initState() { 
    super.initState();
    fetchDistrictData();
  }
  Widget build(BuildContext context) {
    
    return Container(
        child: districtData==null? Center(child: CircularProgressIndicator(),):ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){
            
            return GestureDetector(
              child: Container(
                height: 130,
                width: MediaQuery.of(context).size.width,
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
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          districtData[index2]['districtData'][index]['district'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlue[900]
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
                                 districtData[index2]['districtData'][index]['confirmed'].toString(),
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
                            //       districtData['data']['regional'][index]['totalConfirmed'].toString(),
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
                                   districtData[index2]['districtData'][index]['recovered'].toString(),
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
                                   districtData[index2]['districtData'][index]['deceased'].toString(),
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
              ),
            );
          },
          itemCount: districtData==null ? 0: districtData[index2]['districtData'].length,
        ),
    );
  }
}
