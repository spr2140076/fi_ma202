// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'deferred_payments.dart';
//
// const String columnDeferredPaymentId = '_deferred_payment_id';
// const String columnDeferredPaymentCategoryCode = 'deferred_payment_category_code';
// const String columnDeferredPaymentGenreCode = 'deferred_payment_genre_code';
// const String columnPaymentMethodId = 'payment_method_id';
// const String columnDeferredPaymentName = 'deferred_payment_name';
// const String columnDeferredPaymentTotalMoney = 'deferred_payment_total_money';
// const String columnDeferredPaymentConsumptionTax = 'deferred_payment_consumption_tax';
// const String columnDeferredPaymentAmountIncludingTax = 'deferred_payment_amount_including_tax';
// const String columnDeferredPaymentDateTime = 'deferred_payment_datetime';
// const String columnDeferredPaymentMemo = 'deferred_payment_memo';
// const String columnDeferredPaymentCreatedAt = 'deferred_payment_created_at';
// const String columnDeferredPaymentUpdatedAt = 'deferred_payment_updated_at';
//
// const List<String> deferred_paymentcolumns = [
//   columnDeferredPaymentId,
//   columnDeferredPaymentCategoryCode,
//   columnDeferredPaymentGenreCode,
//   columnPaymentMethodId,
//   columnDeferredPaymentName,
//   columnDeferredPaymentTotalMoney,
//   columnDeferredPaymentConsumptionTax,
//   columnDeferredPaymentAmountIncludingTax,
//   columnDeferredPaymentDateTime,
//   columnDeferredPaymentMemo,
//   columnDeferredPaymentCreatedAt,
//   columnDeferredPaymentUpdatedAt,
// ];
//
// class DeferredPaymentDbHelper {
//   // DbHelperをinstance化する
//   static final DeferredPaymentDbHelper deferred_paymentinstance = DeferredPaymentDbHelper._createInstance();
//   static Database? _deferred_paymentdatabase;
//
//   DeferredPaymentDbHelper._createInstance();
//
//   // databaseをオープンしてインスタンス化する
//   Future<Database> get deferred_paymentdatabase async {
//     return _deferred_paymentdatabase ??= await _initDB(); // 初回だったら_initDB()=DBオープンする
//   }
//
//   // データベースをオープンする
//   Future<Database> _initDB() async {
//     String path = join(await getDatabasesPath(), 'deferred_payments.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onDeferredPaymentCreate, // cats.dbがなかった時の処理を指定する（DBは勝手に作られる）
//     );
//   }
//
//   Future _onDeferredPaymentCreate(Database database, int version) async {
//     //catsテーブルをcreateする
//     await database.execute('''
//       CREATE TABLE deferred_payments(
//         _deferred_payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
//         deferred_payment_category_code TEXT,
//         deferred_payment_genre_code TEXT,
//         payment_method_id TEXT,
//         deferred_payment_name TEXT,
//         deferred_payment_total_money INTEGER,
//         deferred_payment_consumption_tax INTEGER,
//         deferred_payment_amount_including_tax INTEGER,
//         deferred_payment_datetime INTEGER,
//         deferred_payment_memo TEXT,
//         deferred_payment_created_at TEXT,
//         deferred_payment_updated_at TEXT
//       )
//     ''');
//   }
//
//   Future<List<DeferredPayments>> selectAllDeferredPayments() async {
//     final db = await deferred_paymentinstance.deferred_paymentdatabase;
//     final deferred_paymentsData = await db.query('deferred_payments');          // 条件指定しないでcatsテーブルを読み込む
//
//     return deferred_paymentsData.map((json) => DeferredPayments.fromJson(json)).toList();    // 読み込んだテーブルデータをListにパースしてreturn
//   }
//
//   Future<DeferredPayments> deferred_paymentData(int id) async {
//     final db = await deferred_paymentinstance.deferred_paymentdatabase;
//     var deferred_payment = [];
//     deferred_payment = await db.query(
//       'deferred_payments',
//       columns: deferred_paymentcolumns,
//       where: '_deferred_payment_id = ?',                     // 渡されたidをキーにしてcatsテーブルを読み込む
//       whereArgs: [id],
//     );
//     return DeferredPayments.fromJson(deferred_payment.first);      // 1件だけなので.toListは不要
//   }
//
//   Future deferred_paymentinsert(DeferredPayments deferred_payments) async {
//     final db = await deferred_paymentdatabase;
//     return await db.insert(
//         'deferred_payments',
//         deferred_payments.toJson()                         // cats.dartで定義しているtoJson()で渡されたcatsをパースして書き込む
//     );
//   }
//
//   Future deferred_paymentupdate(DeferredPayments deferred_payments) async {
//     final db = await deferred_paymentdatabase;
//     return await db.update(
//       'deferred_payments',
//       deferred_payments.toJson(),
//       where: '_deferred_payment_id = ?',                   // idで指定されたデータを更新する
//       whereArgs: [deferred_payments.deferred_payment_id],
//     );
//   }
//
//   Future deferred_paymentdelete(int id) async {
//     final db = await deferred_paymentinstance.deferred_paymentdatabase;
//     return await db.delete(
//       'deferred_payments',
//       where: '_deferred_payment_id = ?',                   // idで指定されたデータを削除する
//       whereArgs: [id],
//     );
//   }
// }