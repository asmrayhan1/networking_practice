import 'package:networking_practice/screen/model/pair/pair.dart';

import '../../model/category/category_model.dart';

class CategoryGeneric {
  bool isLoading;
  List<CategoryModel> myCategory;
  List<Pair<int, CategoryModel>> tmpCategory;
  CategoryGeneric({this.isLoading=false, this.myCategory = const [], this.tmpCategory = const []});
  CategoryGeneric update({bool? isLoading, List<CategoryModel>? currentCategory, List<Pair<int, CategoryModel>>? newCategory}) {
    return CategoryGeneric(
        isLoading: isLoading?? this.isLoading,
        myCategory: currentCategory?? this.myCategory,
        tmpCategory: newCategory?? this.tmpCategory
    );
  }
}