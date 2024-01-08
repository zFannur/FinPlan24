import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finplan24/domain/domain.dart';
import 'package:realm/realm.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required this.categoriesRepository,
    required this.subCategoriesRepository,
  }) : super(const CategoriesState());

  final IGenericCategoriesRepository<Category> categoriesRepository;
  final IGenericCategoriesRepository<SubCategory> subCategoriesRepository;

  void getAllCategories() {
    emit(
      state.copyWith(
        status: () => CategoriesStatus.loading,
      ),
    );
    final categories = categoriesRepository.getAll();
    final subCategories = subCategoriesRepository.getAll();
    emit(
      state.copyWith(
        status: () => CategoriesStatus.success,
        categories: () => categories,
        subCategories: () => subCategories,
      ),
    );
  }

  void searchCategories(String query) {
    emit(
      state.copyWith(
        status: () => CategoriesStatus.loading,
      ),
    );
    final categories = categoriesRepository
        .getAll()
        .where((element) => element.name.contains(query))
        .toList();
    final subCategories = subCategoriesRepository
        .getAll()
        .where((element) => element.name.contains(query))
        .toList();
    emit(
      state.copyWith(
        status: () => CategoriesStatus.success,
        categories: () => categories,
        subCategories: () => subCategories,
      ),
    );
  }

  void getUnloadedCategories(List<Operation> operations) {
    final loadedCategories = state.categoriesName;
    final subCategories = state.subCategoriesName;

    final categories = operations.map((e) => e.category).toSet()
      ..removeAll(loadedCategories);
    final unloadedCategories = operations.map((e) => e.subCategory).toSet()
      ..addAll(categories)
      ..removeAll(subCategories);

    emit(
      state.copyWith(
        unloadedCategories: () => unloadedCategories.toList(),
      ),
    );
  }

  void editCategories({
    Category? category,
    SubCategory? subCategory,
  }) {
    if (category != null) {
      categoriesRepository.update(category);
    }
    if (subCategory != null) {
      subCategoriesRepository.update(subCategory);
    }
    getAllCategories();
  }

  void deleteCategories({
    required String name,
  }) {
    final category = state.categories.where((element) => element.name == name).toList();
    final subCategory =
        state.subCategories.where((element) => element.name == name).toList();
    if (category.isNotEmpty) {
      categoriesRepository.delete(category.first.id);
    }
    if (subCategory.isNotEmpty) {
      subCategoriesRepository.delete(subCategory.first.id);
    }
    getAllCategories();
  }

  void addCategories({
    required String category,
    required CategoryType type,
  }) {
    if (type == CategoryType.category) {
      categoriesRepository.add(Category(Uuid.v4().toString(), category));
    }
    if (type == CategoryType.subCategory) {
      subCategoriesRepository.add(SubCategory(Uuid.v4().toString(), category));
    }
    getAllCategories();
  }

  void addAll({
    required List<String> list,
    required CategoryType type,
  }) {
    if (type == CategoryType.category) {
      categoriesRepository
          .addAll(list.map((e) => Category(Uuid.v4().toString(), e)).toList());
    }
    if (type == CategoryType.subCategory) {
      subCategoriesRepository.addAll(
        list.map((e) => SubCategory(Uuid.v4().toString(), e)).toList(),
      );
    }
    getAllCategories();
  }
}
