import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/deferred_payment/deferred_payment_db_helper.dart';
import '../../model/deferred_payment/deferred_payments.dart';



class DeferredPaymentDetailEdit extends StatefulWidget {
  final DeferredPayments? deferred_payments;
  const DeferredPaymentDetailEdit({Key? key, this.deferred_payments}) : super(key: key);

  @override
  _DeferredPaymentDetailEditState createState() => _DeferredPaymentDetailEditState();
}

class _DeferredPaymentDetailEditState extends State<DeferredPaymentDetailEdit> {
  late int deferred_payment_id;
  late String deferred_payment_category_code;
  late String deferred_payment_genre_code;
  late String payment_method_id;
  late String deferred_payment_name;
  late int deferred_payment_total_money;
  late int deferred_payment_consumption_tax;
  late int deferred_payment_amount_including_tax;
  late DateTime deferred_payment_datetime;
  late String deferred_payment_memo;
  late DateTime deferred_payment_created_at;
  late DateTime deferred_payment_updated_at;
  final List<String> _deferred_payment_category = <String>['支出カテゴリの選択','食費', '交通費', '固定費', '交際費'];
  late String _deferred_payment_category_selected;
  final List<String> _payment= <String>['支払い方法を選択','現金', 'クレジット', '電子マネー'];
  late String _payment_selected;
  String which = '後払い';
  bool get isShow {
    return which == '後払い';
  }
  dynamic deferred_paymentDateTime;
  dynamic deferred_paymentDateFormat;
// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、各項目の初期値を設定する
  @override
  void initState() {
    super.initState();
    // print(widget.deferred_payments);
    // deferred_payment
    deferred_payment_id = widget.deferred_payments?.deferred_payment_id ?? 0;
    deferred_payment_category_code = widget.deferred_payments?.deferred_payment_category_code ?? '';
    deferred_payment_genre_code = widget.deferred_payments?.deferred_payment_genre_code ?? '通常';
    payment_method_id = widget.deferred_payments?.payment_method_id ?? '';
    deferred_payment_name = widget.deferred_payments?.deferred_payment_name ?? '';
    deferred_payment_total_money = widget.deferred_payments?.deferred_payment_total_money ?? 0;
    deferred_payment_consumption_tax = widget.deferred_payments?.deferred_payment_consumption_tax ?? 0;
    deferred_payment_amount_including_tax = widget.deferred_payments?.deferred_payment_amount_including_tax ?? 0;
    deferred_payment_datetime = widget.deferred_payments?.deferred_payment_datetime ?? DateTime.now();
    deferred_payment_memo = widget.deferred_payments?.deferred_payment_memo ?? '';
    deferred_payment_created_at = widget.deferred_payments?.deferred_payment_created_at ?? DateTime.now();
    deferred_payment_updated_at = widget.deferred_payments?.deferred_payment_updated_at ?? DateTime.now();
    _deferred_payment_category_selected = widget.deferred_payments?.deferred_payment_category_code ?? '支出カテゴリの選択';
    _payment_selected = widget.deferred_payments?.payment_method_id ?? '支払い方法を選択';
    deferred_paymentDateTime = DateTime.now();
    deferred_paymentDateFormat = DateFormat("yyyy年MM月dd日").format(deferred_paymentDateTime);
  }

  void _onChangedDeferredPaymentCategory(String? value) {
    setState(() {
      _deferred_payment_category_selected = value!;
      deferred_payment_category_code = _deferred_payment_category_selected;
    });
  }

  void _onChangedPayment(String? value) {
    setState(() {
      _payment_selected = value!;
      payment_method_id = _payment_selected;
    });
  }

  void _onChangedGenre(String? value) {
    setState(() {
      which = value!;
      deferred_payment_genre_code = which;
    });
  }

  _deferred_paymentDatePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        locale: const Locale("ja"),
        context: context,
        initialDate: deferred_paymentDateTime,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    print(datePicked);
    if (datePicked != null && datePicked != deferred_paymentDateTime) {
      setState(() {
        deferred_paymentDateFormat = DateFormat("yyyy年MM月dd日").format(datePicked);
        deferred_paymentDateTime = datePicked;
        deferred_payment_datetime = deferred_paymentDateTime;
      });
    }
  }

  void createOrUpdateDeferredPayment() async {
    final isUpdate = (widget.deferred_payments != null);

    // print(deferred_payment_name);
    print(widget.deferred_payments);// 画面が空でなかったら

    if (isUpdate) {
      await updateDeferredPayment();                        // updateの処理
    } else {
      await createDeferredPayment();                        // insertの処理
    }
    Navigator.of(context).pop();                // 前の画面に戻る
  }

  // 更新処理の呼び出し
  Future updateDeferredPayment() async {
    final deferred_payment = widget.deferred_payments!.copy(              // 画面の内容をcatにセット
      deferred_payment_category_code: deferred_payment_category_code,
      deferred_payment_genre_code: deferred_payment_genre_code,
      payment_method_id: payment_method_id,
      deferred_payment_name: deferred_payment_name,
      deferred_payment_amount_including_tax: deferred_payment_amount_including_tax,
      deferred_payment_datetime: deferred_payment_datetime,
      deferred_payment_memo: deferred_payment_memo,
      deferred_payment_updated_at: deferred_payment_updated_at,
    );
    await DeferredPaymentDbHelper.deferred_paymentinstance.deferred_paymentupdate(deferred_payment);        // catの内容で更新する
  }

  // db処理メソッド
  Future createDeferredPayment() async {
    final deferred_payment = DeferredPayments(                           // 入力された内容をcatにセット
      deferred_payment_id: deferred_payment_id,
      deferred_payment_category_code: deferred_payment_category_code,
      deferred_payment_genre_code: deferred_payment_genre_code,
      payment_method_id: payment_method_id,
      deferred_payment_name: deferred_payment_name,
      deferred_payment_total_money: 0,
      deferred_payment_consumption_tax: 0,
      deferred_payment_amount_including_tax: deferred_payment_amount_including_tax,
      deferred_payment_datetime: deferred_payment_datetime,
      deferred_payment_memo: deferred_payment_memo,
      deferred_payment_created_at: deferred_payment_created_at,
      deferred_payment_updated_at: deferred_payment_updated_at,
    );
    await DeferredPaymentDbHelper.deferred_paymentinstance.deferred_paymentinsert(deferred_payment);        // catの内容で追加する
  }

// 詳細編集画面を表示する
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 50,),
          onPressed: () => Navigator.of(context).pop(),  // 遷移元のページをpop
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                // Container(
                //   child: const TabBar(
                //     labelColor: Colors.orange,
                //     unselectedLabelColor: Colors.black,
                //     tabs: [
                //       Tab(text: '支出'),
                //       Tab(text: '収入'),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 20,),

                Container(
                  height: 600,
                  child: TabBarView(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: const Text('後払い', style: TextStyle(fontSize: 25),),
                            ),
                            Visibility(
                              visible: isShow,
                              // 品目欄
                              child: Container(
                                width: 350,
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(),
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(15),
                                      child:  const Text(
                                        '支払名',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 230,
                                      height: 40,
                                      child: TextFormField(
                                        initialValue: deferred_payment_name,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(0),
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (deferred_payment_change_name) => setState(() => this.deferred_payment_name = deferred_payment_change_name),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 300,
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(),
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // 円マーク
                                  Container(
                                    child: const Text(
                                      '￥',
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 230,
                                    height: 60,
                                    child: TextFormField(
                                        initialValue: deferred_payment_amount_including_tax.toString(),
                                        style: const TextStyle(fontSize: 40),
                                        textAlign: TextAlign.right,
                                        keyboardType: TextInputType.number,
                                        onChanged: (change_deferred_payment_money) => setState(() => deferred_payment_amount_including_tax = int.parse(change_deferred_payment_money))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              child: OutlinedButton(
                                  child:Text(deferred_paymentDateFormat),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    _deferred_paymentDatePicker(context);
                                  }),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              width: 220,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 220,
                                    height: 50,
                                    child: DropdownButton<String>(
                                      items: _deferred_payment_category.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      value: _deferred_payment_category_selected,
                                      onChanged: _onChangedDeferredPaymentCategory,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              width: 220,
                              child: Row(
                                children: <Widget>[
                                  DropdownButton<String>(
                                    items: _payment.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    value: _payment_selected,
                                    onChanged: _onChangedPayment,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: const Align(
                                alignment: Alignment(-0.7,0),
                                child: Text('メモ', style: TextStyle(fontSize: 25),),
                              ),
                            ),
                            Container(
                              width: 280,
                              child: TextFormField(
                                initialValue: deferred_payment_memo,
                                decoration: const InputDecoration(
                                    hintText: 'メモを入力してください',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    )
                                ),
                                onChanged: (deferred_payment_change_memo) => setState(() => this.deferred_payment_memo = deferred_payment_change_memo),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              height: 50,
                              width: 100,
                              child: ElevatedButton(
                                child: const Text('登録', style: TextStyle(fontSize: 20),),
                                onPressed: createOrUpdateDeferredPayment,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}