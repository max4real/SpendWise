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
  String? description;
  String? transferGroupId;

  TransactionListModel({
    required this.id,
    required this.remark,
    required this.amount,
    required this.tarnType,
    required this.createdAt,
    this.category,
    this.image,
    this.subType,
    this.description,
    this.transferGroupId,
  });

  factory TransactionListModel.forList({required Map<String, dynamic> data}) {
    CategoryModel? categoryModel;

    if (data['category'] != null) {
      categoryModel = CategoryModel.fromAPI(data: data['category']);
    }

    return TransactionListModel(
      id: data['id'] ?? '',
      remark: data['remark'] ?? '',
      amount: int.tryParse(data['amount'].toString()) ?? -1,
      tarnType: data['type'] ?? '',
      createdAt: DateTime.tryParse(data['createdAt']) ?? DateTime.now(),
      category: categoryModel,
      transferGroupId: data["transferGroupId"] ?? '',
    );
  }

  factory TransactionListModel.forListWithAllField(
      {required Map<String, dynamic> data}) {
    CategoryModel? categoryModel;
    String? image;
    String? description;

    if (data['category'] != null) {
      categoryModel = CategoryModel.fromAPI(data: data['category']);
    }
    if (data['attachmentImage'] != null) {
      image = data['attachmentImage'] ?? '';
    }
    if (data['description'] != null) {
      description = data['description'] ?? '';
    }

    return TransactionListModel(
      id: data['id'] ?? '',
      remark: data['remark'] ?? '',
      amount: int.tryParse(data['amount'].toString()) ?? -1,
      tarnType: data['type'] ?? '',
      createdAt: DateTime.tryParse(data['createdAt']) ?? DateTime.now(),
      transferGroupId: data["transferGroupId"] ?? "",
      category: categoryModel,
      image: image,
      subType: data["account"]["accountSubType"] ?? "",
      description: description,
    );
  }
}
