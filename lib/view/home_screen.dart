import 'package:fi_ma/view/register/exin_detail_edit.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fi-MA', style: TextStyle(fontSize: 25),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 40,
                    child: Text('一週間以内未払い請求書', style: TextStyle(fontSize: 25, color: Colors.orange),),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 250,
              //color: Colors.lightGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    //color: Colors.cyan,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                      Expanded(
                        child: PieChart(
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
                        Text('￥100,000', style: TextStyle(fontSize: 30, decoration: TextDecoration.underline),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
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
              height: 150,
              // color: Colors.yellowAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('食費', style: TextStyle(fontSize: 25),),
                  SizedBox(width: 15,),
                  Text('￥2,000', style: TextStyle(fontSize: 25),)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {                                       // ＋ボタンを押したときの処理を設定
          await Navigator.of(context).push(                         // ページ遷移をNavigatorで設定
            MaterialPageRoute(
                builder: (context) => const ExpenseDetailEdit()           // 詳細更新画面（元ネタがないから新規登録）を表示するcat_detail_edit.dartへ遷移
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}