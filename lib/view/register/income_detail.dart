import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/register/income_db_helper.dart';
import '../../model/register/incomes.dart';
import 'exin_detail_edit.dart';

class IncomeDetail extends StatefulWidget {
  final int id;

  const IncomeDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<IncomeDetail> createState() => _IncomeDetailState();
}

class _IncomeDetailState extends State<IncomeDetail> {
  late Incomes incomes;
  bool isLoading = false;
  static const int textExpandedFlex = 2; // 見出しのexpaded flexの比率
  static const int dataExpandedFlex = 4; // 項目のexpanede flexの比率


// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、渡されたidをキーとしてcatsテーブルからデータを取得する
  @override
  void initState() {
    super.initState();
    incomeData();
  }

// initStateで動かす処理
// catsテーブルから指定されたidのデータを1件取得する
  Future incomeData() async {
    setState(() => isLoading = true);
    incomes = await IncomeDbHelper.incomeinstance.incomeData(widget.id);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('収入詳細'),
          actions: [
            IconButton(
              onPressed: () async {                          // 鉛筆のアイコンが押されたときの処理を設定
                await Navigator.of(context).push(            // ページ遷移をNavigatorで設定
                  MaterialPageRoute(
                    builder: (context) => ExpenseDetailEdit(    // 詳細更新画面を表示する
                      incomes: incomes,
                    ),
                  ),
                );
                incomeData();                                  // 更新後のデータを読み込む
              },
              icon: const Icon(Icons.edit),                 // 鉛筆マークのアイコンを表示
            ),
            IconButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context){
                    return CupertinoAlertDialog(
                      title: Text('削除'),
                      content: Text('削除しますか？'),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('キャンセル'),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: Text('削除'),
                          onPressed: () async {
                            await IncomeDbHelper.incomeinstance.incomedelete(widget.id);
                            int count = 0;
                            Navigator.popUntil(context, (_) => count++ >= 2);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete),               // ゴミ箱マークのアイコンを表示
            )
          ],
        ),
        body: isLoading                                     //「読み込み中」だったら「グルグル」が表示される
            ? const Center(
          child: CircularProgressIndicator(),         // これが「グルグル」の処理
        )
            : Column(
          children :[
            Column(                                             // 縦並びで項目を表示
              crossAxisAlignment: CrossAxisAlignment.stretch,   // 子要素の高さを合わせる
              children: [
                Row(children: [
                  const Expanded(                               // 見出しの設定
                    flex: textExpandedFlex,
                    child: Text('日付',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: dataExpandedFlex,
                    child: Container(                           // catsテーブルのnameの表示を設定
                      padding: const EdgeInsets.all(5.0),
                      child: Text(DateFormat("yyyy年MM月dd日").format(incomes.income_day),
                        style: const TextStyle(fontSize: 20),),
                    ),
                  ),
                ],),
                Row(children: [
                  const Expanded(     // 「メモ」の見出し行の設定
                      flex: textExpandedFlex,
                      child: Text('税込金額',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      )
                  ),
                  Expanded(
                    flex: dataExpandedFlex,
                    child: Container(                                      // catsテーブルのmemoの表示を設定
                      padding: const EdgeInsets.all(5.0),
                      child: Text(incomes.income_money.toString() + '円',
                        style: const TextStyle(fontSize: 20),),
                    ),
                  ),
                ],),
                Row(children: [
                  const Expanded(           // 「誕生日」の見出し行の設定
                    flex: textExpandedFlex,
                    child: Text('カテゴリー',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: dataExpandedFlex,
                    child: Container(                                      // catsテーブルのbirthdayの表示を設定
                      padding: const EdgeInsets.all(5.0),
                      child: Text(incomes.income_category_code,
                        style: const TextStyle(fontSize: 20),),
                    ),
                  )
                ],),
                Row(children: [
                  const Expanded(     // 「メモ」の見出し行の設定
                      flex: textExpandedFlex,
                      child: Text('メモ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      )
                  ),
                  Expanded(
                    flex: dataExpandedFlex,
                    child: Container(                                      // catsテーブルのmemoの表示を設定
                      padding: const EdgeInsets.all(5.0),
                      child: Text(incomes.income_memo,
                        style: const TextStyle(fontSize: 20),),
                    ),
                  ),
                ],),
              ],
            ),
          ],
        )
    );
  }
}