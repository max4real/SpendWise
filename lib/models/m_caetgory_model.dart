class CategoryModel {
  String categoryID;
  String categoryName;
  String categoryIcon;
  bool categoryPrivacy;
  CategoryModel({
    required this.categoryID,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryPrivacy,
  });

  factory CategoryModel.fromAPI({required Map<String, dynamic> data}) {
    return CategoryModel(
      categoryID: data['id'].toString(),
      categoryName: data['name'].toString(),
      categoryIcon: data['icon'] ?? '',
      categoryPrivacy: data['isPrivate'],
    );
  }
}
