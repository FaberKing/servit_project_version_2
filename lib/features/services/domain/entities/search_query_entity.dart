// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:servit_project_version_2/features/services/data/model/search_query_model.dart';

class SearchQueryEntity extends Equatable {
  final String? querySearch;
  final String? queryCategory;
  final String? queryRating;

  const SearchQueryEntity({
    this.querySearch,
    this.queryCategory,
    this.queryRating,
  });

  static const empty = SearchQueryEntity(
    queryCategory: '',
    querySearch: '',
    queryRating: '',
  );

  SearchQueryModel get toModel => SearchQueryModel(
        querySearch: querySearch,
        queryCategory: queryCategory,
        queryRating: queryRating,
      );

  @override
  List<Object?> get props => [querySearch, queryCategory, queryRating];

  SearchQueryEntity copyWith({
    String? querySearch,
    String? queryCategory,
    String? queryRating,
  }) {
    return SearchQueryEntity(
      querySearch: querySearch ?? this.querySearch,
      queryCategory: queryCategory ?? this.queryCategory,
      queryRating: queryRating ?? this.queryRating,
    );
  }
}
