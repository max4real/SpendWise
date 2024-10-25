import 'package:spend_wise/models/m_caetgory_model.dart';

class TransactionListModel {
  String id;
  String remark;
  int amount;
  String tarnType;
  DateTime createdAt;
  CategoryModel? category;
  String? image;
  String? subType;
  String? from;
  String? to;
  String? description;

  TransactionListModel({
    required this.id,
    required this.remark,
    required this.amount,
    required this.tarnType,
    required this.createdAt,
    this.category,
    this.image,
    this.subType,
    this.from,
    this.to,
    this.description,
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
  factory TransactionListModel.forListWithImage(
      {required Map<String, dynamic> data}) {
    CategoryModel? categoryModel;
    String? image;
    String? subType;
    String? from;
    String? to;
    String? description;

    if (data['from'] != null) {
      subType = data['from']['subType'] ?? "";
      from = data['from']['subType'] ?? "";
    }
    if (data['to'] != null) {
      subType = data['to']['subType'] ?? "";
      to = data['to']['subType'] ?? "";
    }

    if (data['category'] != null) {
      categoryModel = CategoryModel.fromAPI(data: data['category']);
    }
    if (data['image'] != null) {
      image = data['image'] ?? '';
    }
    if (data['description'] != null) {
      description = data['description'] ?? '';
    }

    return TransactionListModel(
      id: data['id'] ?? '',
      remark: data['remark'] ?? '',
      amount: data['amount'] as int,
      tarnType: data['type'] ?? '',
      createdAt: DateTime.tryParse(data['createdAt']) ?? DateTime.now(),
      category: categoryModel,
      image: image,
      subType: subType,
      from: from,
      to: to,
      description: description,
    );
  }
}
// {
//         "id": "67520fcb-3169-47b4-9a8a-42fb459a90d9",
//         "remark": "say late wal",
//         "image": "https://res.cloudinary.com/dwrgwvvdk/image/upload/v1729863382/spendwise/transaction/xmnyjjpsjhpnjzhfojuw.jpg",
//         "amount": 3500,
//         "type": "EXPENSE",
//         "from": null,
//         "to": {
//           "id": "d950ea6e-d3de-47ae-be5a-83df954b9abb",
//           "name": "AYA Bank - ",
//           "type": "BANK",
//           "subType": "AYABANK"
//         },
//         "category": {
//           "id": "6c48b7f8-0719-46b9-acdf-a3ae5a1b6c4d",
//           "name": "Shopping",
//           "icon": null,
//           "isPrivate": false
//         },
//         "createdAt": "2024-10-25T13:36:23.036Z"
//       },