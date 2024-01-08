part of 'categories_cubit.dart';

enum CategoriesStatus { initial, loading, success, failure }

final class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = CategoriesStatus.initial,
    this.categories = const [],
    this.subCategories = const [],
    this.unloadedCategories = const [],
    this.error,
  });

  final CategoriesStatus status;
  final List<Category> categories;
  final List<SubCategory> subCategories;
  final List<String> unloadedCategories;
  final String? error;

  List<dynamic> get allCategories => [categories, subCategories];

  List<String> get categoriesName => categories.map((e) => e.name).toList();

  List<String> get subCategoriesName =>
      subCategories.map((e) => e.name).toList();

  CategoriesState copyWith({
    CategoriesStatus Function()? status,
    List<Category> Function()? categories,
    List<SubCategory> Function()? subCategories,
    List<String> Function()? unloadedCategories,
    String Function()? error,
  }) {
    return CategoriesState(
      status: status != null ? status() : this.status,
      categories: categories != null ? categories() : this.categories,
      subCategories:
          subCategories != null ? subCategories() : this.subCategories,
      unloadedCategories: unloadedCategories != null
          ? unloadedCategories()
          : this.unloadedCategories,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
        subCategories,
        unloadedCategories,
        error,
      ];
}
