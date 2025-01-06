import 'package:spend_wise/models/m_caetgory_model.dart';

class BudgetModel {
  String id;
  double budgetAmount;
  double budgetUsed;
  double remainingAmount;
  String categoryID;
  bool notification;
  double percentage;
  CategoryModel categoryModel;
  BudgetModel({
    required this.id,
    required this.budgetAmount,
    required this.budgetUsed,
    required this.remainingAmount,
    required this.categoryID,
    required this.notification,
    required this.percentage,
    required this.categoryModel,
  });

  factory BudgetModel.fromAPI({required Map<String, dynamic> data}) {
    return BudgetModel(
      id: data["id"].toString(),
      budgetAmount: double.tryParse(data['amount'].toString()) ?? -1,
      budgetUsed: double.tryParse(data['spentAmount'].toString()) ?? -1,
      remainingAmount:
          double.tryParse(data['remainingAmount'].toString()) ?? -1,
      notification: bool.tryParse(data["notification"]["isEnabled"].toString()) ?? false,
      percentage: double.tryParse(data['percentage'].toString()) ?? 1,
      categoryID: data["categoryId"].toString(),
      categoryModel: CategoryModel.fromAPI(data: data["category"]),
    );
  }
}

// {
//     "id": "4be45abe-762e-4738-996d-d21a6a90ceb9",
//     "amount": 50000,
//     "categoryId": "b292631c-2bb6-448a-9657-dd342873ae66",
//     "createdAt": "2025-01-06T04:59:47.253Z",
//     "updatedAt": "2025-01-06T04:59:47.253Z",
//     "notification": {
//       "isEnabled": true
//     },
//     "percentage": 51,
//     "userId": "68531fd8-61a9-48d2-aa06-60a82891b499",
//     "category": {
//       "id": "b292631c-2bb6-448a-9657-dd342873ae66",
//       "name": "Food",
//       "icon": null,
//       "private": false,
//       "createdAt": "2025-01-06T04:32:53.577Z",
//       "updatedAt": "2025-01-06T04:32:53.577Z"
//     },
//     "spentAmount": 0,
//     "remainingAmount": 50000
//   }
