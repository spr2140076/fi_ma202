import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/register/expense_db_helper.dart';
import '../register/exin_detail_edit.dart';

// void main() {
//   runApp(const MyApp());
// }

// class Budget extends StatelessWidget {
//   const Budget({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  State<Budget> createState() => _Budget();
}

class _Budget extends State<Budget> {

  double month = 0;
  double week = 0;
  double day = 0;
  double weekbudget = 0;
  double daybudget = 0;
  DateTime _now = DateTime.now();
  bool isLoading = false;
  List<Map<String, dynamic>> totalExpense = [];
  List<Map<String, dynamic>> totalExpenseToday = [];
  int total = 0;
  int totalToday = 0;

  TextEditingController moneyController = TextEditingController();

  double weekCalc(double month) {
    week = (month / 4);
    return week;
  }

  double dayCalc(double week) {
    day = (week / 30);
    return day;
  }

  Future getExpenseData() async {
    setState(() => isLoading = true);
    _now = DateTime.now();
    var dtFormat = DateFormat("yy-MM");
    String strDate = dtFormat.format(_now);
    final db = await ExpenseDbHelper.expenseinstance.expensedatabase;
    final String sql = "SELECT expense_amount_including_tax FROM Expenses WHERE expense_datetime LIKE '%$strDate%'";
    final List<Map<String, dynamic>> result = await db.rawQuery(sql);
    totalExpense = result;

    for(int i = 0; i < result.length; i++) {
      int sum = result[i]['expense_amount_including_tax'];
      total += sum;
    }
    setState(() => isLoading = false);
  }

  Future getExpenseDataToday() async {
    setState(() => isLoading = true);
    _now = DateTime.now();
    var dtFormat = DateFormat("yy-MM-dd");
    String strDate = dtFormat.format(_now);
    print(strDate);
    final db = await ExpenseDbHelper.expenseinstance.expensedatabase;
    final String sql = "SELECT expense_amount_including_tax FROM Expenses WHERE expense_datetime LIKE '%$strDate%'";
    final List<Map<String, dynamic>> result = await db.rawQuery(sql);
    totalExpenseToday = result;

    for(int i = 0; i < result.length; i++) {
      int sum = result[i]['expense_amount_including_tax'];
      totalToday += sum;
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    print(month);
    print(week);
    print(day);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.50),
        child: AppBar(
          title: Text('今月の予算', style: TextStyle(fontSize: 25),),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 80,
              //color: Colors.cyanAccent,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 30,),
                  Container(
                    width: 210,
                    height: 50,
                    //color: Colors.red,
                    child: TextField(
                      controller: moneyController,
                      maxLength: 7,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFf0f8ff),
                          hintText: '予算を入力してください'
                      ),
                    ),
                  ),
                  SizedBox(width: 40,),
                  Container(
                    width: 70,
                    height: 50,
                    color: Colors.orange,
                    child: ElevatedButton(
                      child: const Text('設定', style: TextStyle(fontSize: 18),),
                      onPressed: () {
                        setState(() {
                          month = double.parse(moneyController.text);
                          weekbudget = weekCalc(month);
                          daybudget =  dayCalc(month) as double;
                        });
                        getExpenseData();
                        getExpenseDataToday();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 40,
              child: Text('使用金額', style: TextStyle(fontSize: 30),),
            ),
            SizedBox(height: 30,),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.red,
                      width: 10,
                    ),
                  )
              ),
              child: Row(
                children: <Widget>[
                  Text('今月', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 25,),
                  Text('¥', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text(total.toString(), style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text('/', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text('¥', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text((month.floor()).toString(), style: TextStyle(fontSize:30),),
                ],
              ),
            ),
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue,
                      width: 10,
                    ),
                  )
              ),
              child: Row(
                children: <Widget>[
                  Text('今週', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 25,),
                  Text('¥', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text('7,000', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text('/', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text('¥', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text((weekbudget.floor()).toString(), style: TextStyle(fontSize:30),),
                ],
              ),
            ),
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.green,
                      width: 10,
                    ),
                  )
              ),
              child: Row(
                children: <Widget>[
                  Text('今日', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 25,),
                  Text('¥', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text(totalToday.toString(), style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text('/', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text('¥', style: TextStyle(fontSize: 30),),
                  SizedBox(width: 10,),
                  Text((daybudget.floor()).toString(), style: TextStyle(fontSize:30),),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
