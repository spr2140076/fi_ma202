// import 'deferred_payment_db_helper.dart';
// import 'package:intl/intl.dart';
//
// // DeferredPaymentsテーブルの定義
// class DeferredPayments {
//   int deferred_payment_id;
//   String deferred_payment_category_code;
//   String deferred_payment_genre_code;
//   String payment_method_id;
//   String deferred_payment_name;
//   int deferred_payment_total_money;
//   int deferred_payment_consumption_tax;
//   int deferred_payment_amount_including_tax;
//   DateTime deferred_payment_datetime;
//   String deferred_payment_memo;
//   DateTime deferred_payment_created_at;
//   DateTime deferred_payment_updated_at;
//
//   DeferredPayments({
//     required this.deferred_payment_id,
//     required this.deferred_payment_category_code,
//     required this.deferred_payment_genre_code,
//     required this.payment_method_id,
//     required this.deferred_payment_name,
//     required this.deferred_payment_total_money,
//     required this.deferred_payment_consumption_tax,
//     required this.deferred_payment_amount_including_tax,
//     required this.deferred_payment_datetime,
//     required this.deferred_payment_memo,
//     required this.deferred_payment_created_at,
//     required this.deferred_payment_updated_at,
//   });
//
// // 更新時のデータを入力項目からコピーする処理
//   DeferredPayments copy({
//     int? deferred_payment_id,
//     String? deferred_payment_category_code,
//     String? deferred_payment_genre_code,
//     String? payment_method_id,
//     String? deferred_payment_name,
//     int? deferred_payment_total_money,
//     int? deferred_payment_consumption_tax,
//     int? deferred_payment_amount_including_tax,
//     DateTime? deferred_payment_datetime,
//     String? deferred_payment_memo,
//     DateTime? deferred_payment_created_at,
//     DateTime? deferred_payment_updated_at,
//   }) =>
//       DeferredPayments(
//         deferred_payment_id: deferred_payment_id ?? this.deferred_payment_id,
//         deferred_payment_category_code: deferred_payment_category_code ??
//             this.deferred_payment_category_code,
//         deferred_payment_genre_code: deferred_payment_genre_code ?? this.deferred_payment_genre_code,
//         payment_method_id: payment_method_id ?? this.payment_method_id,
//         deferred_payment_name: deferred_payment_name ?? this.deferred_payment_name,
//         deferred_payment_total_money: deferred_payment_total_money ?? this.deferred_payment_total_money,
//         deferred_payment_consumption_tax: deferred_payment_consumption_tax ??
//             this.deferred_payment_consumption_tax,
//         deferred_payment_amount_including_tax: deferred_payment_amount_including_tax ??
//             this.deferred_payment_amount_including_tax,
//         deferred_payment_datetime: deferred_payment_datetime ?? this.deferred_payment_datetime,
//         deferred_payment_memo: deferred_payment_memo ?? this.deferred_payment_memo,
//         deferred_payment_created_at: deferred_payment_created_at ?? this.deferred_payment_created_at,
//         deferred_payment_updated_at: deferred_payment_updated_at ?? this.deferred_payment_updated_at,
//       );
//
//   static DeferredPayments fromJson(Map<String, Object?> json) =>
//       DeferredPayments(
//         deferred_payment_id: json[columnDeferredPaymentId] as int,
//         deferred_payment_category_code: json[columnDeferredPaymentCategoryCode] as String,
//         deferred_payment_genre_code: json[columnDeferredPaymentGenreCode] as String,
//         payment_method_id: json[columnPaymentMethodId] as String,
//         deferred_payment_name: json[columnDeferredPaymentName] as String,
//         deferred_payment_total_money: json[columnDeferredPaymentTotalMoney] as int,
//         deferred_payment_consumption_tax: json[columnDeferredPaymentConsumptionTax] as int,
//         deferred_payment_amount_including_tax: json[columnDeferredPaymentAmountIncludingTax] as int,
//         deferred_payment_datetime: DateTime.parse(json[columnDeferredPaymentDateTime] as String),
//         deferred_payment_memo: json[columnDeferredPaymentMemo] as String,
//         deferred_payment_created_at: DateTime.parse(
//             json[columnDeferredPaymentCreatedAt] as String),
//         deferred_payment_updated_at: DateTime.parse(
//             json[columnDeferredPaymentUpdatedAt] as String),
//       );
//
//   Map<String, Object> toJson() =>
//       {
//         columnDeferredPaymentCategoryCode: deferred_payment_category_code,
//         columnDeferredPaymentGenreCode: deferred_payment_genre_code,
//         columnPaymentMethodId: payment_method_id,
//         columnDeferredPaymentName: deferred_payment_name,
//         columnDeferredPaymentTotalMoney: deferred_payment_total_money,
//         columnDeferredPaymentConsumptionTax: deferred_payment_consumption_tax,
//         columnDeferredPaymentAmountIncludingTax: deferred_payment_amount_including_tax,
//         columnDeferredPaymentDateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(
//             deferred_payment_datetime),
//         columnDeferredPaymentMemo: deferred_payment_memo,
//         columnDeferredPaymentCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(
//             deferred_payment_created_at),
//         columnDeferredPaymentUpdatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(
//             deferred_payment_updated_at),
//       };
// }