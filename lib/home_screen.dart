import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState() ;
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 35,),
            Container(
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 40,
                    child: OutlinedButton(
                      child: Text('一週間以内未払い請求書', style: TextStyle(fontSize: 25, color: Colors.orange),),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 25,),
                ],
              ),
            ),
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: 250,
              //color: Colors.lightGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 250,
                    //color: Colors.cyan,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                      Container(
                        width: 50,
                        height: 25,
                        color: Colors.cyan,
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: TabBar(
                            controller: _tabController,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(text: '円グラフ',),
                              Tab(text: '棒グラフ',),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            PieChart(
                              PieChartData(
                                  centerSpaceRadius: 60,
                                  startDegreeOffset: 300,  //要検討
                                  sections: [
                                    PieChartSectionData(
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                      color: Colors.red,
                                    ),
                                    PieChartSectionData(
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                      color: Colors.purple,
                                    ),
                                    PieChartSectionData(
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                      color: Colors.blueAccent,
                                    ),
                                    PieChartSectionData(
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                      color: Colors.orange,
                                    ),
                                    PieChartSectionData(
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                      color: Colors.green,
                                    ),
                                    PieChartSectionData(
                                      borderSide: BorderSide(color: Colors.black, width: 1),
                                      color: Colors.yellow,
                                    ),
                                  ]
                              ),
                            ),
                            BarChart(
                              BarChartData(
                                  borderData: FlBorderData(
                                    border: Border(
                                      top: BorderSide.none,
                                      right: BorderSide.none,
                                      left: BorderSide(width: 1),
                                      bottom: BorderSide(width: 1),
                                    ),
                                  ),
                                  groupsSpace: 6,
                                  barGroups: [
                                    BarChartGroupData(x: 1, barRods: [
                                      BarChartRodData(toY: 0.2, width: 10,color: Colors.red),
                                    ]),
                                    BarChartGroupData(x: 2, barRods: [
                                      BarChartRodData(toY: 2, width: 10, color: Colors.purple),
                                    ]),
                                    BarChartGroupData(x: 3, barRods: [
                                      BarChartRodData(toY: 4, width: 10, color: Colors.blue),
                                    ]),
                                    BarChartGroupData(x: 2, barRods: [
                                      BarChartRodData(toY: 4, width: 10, color: Colors.orange),
                                    ]),
                                    BarChartGroupData(x: 5, barRods: [
                                      BarChartRodData(toY: 1, width: 10, color: Colors.green),
                                    ]),
                                    BarChartGroupData(x: 6, barRods: [
                                      BarChartRodData(toY: 3, width: 10, color: Colors.yellow),
                                    ]),
                                  ]
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                    ),
                  ),
                  Container(
                    //color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('今月の予算', style: TextStyle(fontSize: 30),),
                        SizedBox(height: 30,),
                        Text('100,000', style: TextStyle(fontSize: 30, decoration: TextDecoration.underline),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Row(
                children: [
                  Text('合計金額:', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 15,),
                  Text('¥70,000',style: TextStyle(fontSize: 35, decoration: TextDecoration.underline),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.yellowAccent,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}