import 'package:spend_wise/models/m_caetgory_model.dart';

class TransactionListModel {
  String id;
  String remark;
  int amount;
  String tarnType;
  DateTime createdAt;
  CategoryModel? category;

  TransactionListModel({
    required this.id,
    required this.remark,
    required this.amount,
    required this.tarnType,
    required this.createdAt,
    this.category,
  });

  factory TransactionListModel.forList({required Map<String, dynamic> data}) {
    CategoryModel? categoryModel;

    if (data['category'] != null) {
      categoryModel = CategoryModel.fromAPI(data: data['category']);
    }

    return TransactionListModel(
      id: data['id'] ?? '',
      remark: data['remark'] ?? '',
      amount: data['amount'] as int,
      tarnType: data['type'] ?? '',
      createdAt: DateTime.tryParse(data['createdAt']) ?? DateTime.now(),
      category: categoryModel,
    );
  }
}

// {
//         "id": "7d78abcf-852e-4b5e-8c9d-787edd5f5660",
//         "remark": "gvv",
//         "amount": 4555,
//         "type": "INCOME",
//         "category": {
//           "id": "0a0caa12-c0e6-4df8-955d-5c8530536c0b",
//           "name": "Food",
//           "icon": null
//         },
//         "createdAt": "2024-10-24T10:33:44.444Z"
//       },

// remark*	[...]
// description	[...]
// amount*	[...]
// type*	[...]
// from	[...]
// to	[...]
// categoryId	[...]
// image	

// class TransactionModel {
//   String tranID;
//   String tranType;
//   double tranAmount;
//   String categoryID;
//   String tranRemark;
//   String tranDescription;
//   String tranAccountID;
//   DateTime createDateTime;
//   String? tranAttachement;
//   TransactionModel({
//     required this.tranID,
//     required this.tranType,
//     required this.tranAmount,
//     required this.categoryID,
//     required this.tranRemark,
//     required this.tranDescription,
//     required this.tranAccountID,
//     required this.createDateTime,
//     this.tranAttachement,
//   });
// }
