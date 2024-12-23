import '../../model/category/category_model.dart';

class CategoryGeneric {
  bool isLoading;
  List<CategoryModel> myCategory;
  CategoryGeneric({this.isLoading=false, this.myCategory = const []});
  CategoryGeneric update({bool? isLoading, List<CategoryModel>? currentCategory}) {
    return CategoryGeneric(
        isLoading: isLoading?? this.isLoading,
        myCategory: currentCategory?? this.myCategory
    );
  }
}