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
    return TransactionListModel(
        id: data['id'] ?? '',
        remark: data['remark'] ?? '',
        amount: data['amount'] ?? -1,
        tarnType: data['type'] ?? '',
        createdAt: DateTime.tryParse(data['createdAt']) ?? DateTime.now(),
        category: CategoryModel.fromAPI(data: data['category']));
  }
}

// {
//         "id": "28a22d89-4e3c-4f58-8538-f6e21ff4bd03",
//         "remark": "rff",
//         "amount": 500000,
//         "type": "INCOME",
//         "createdAt": "2024-10-24T08:36:50.897Z",
//         "category": {
//           "id": "eb3e297b-987c-4906-9299-18ec2d372027",
//           "name": "Salary",
//           "icon": null
//         }
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
