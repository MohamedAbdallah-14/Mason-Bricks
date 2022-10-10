import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/data/api_manager.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/nullable.dart';
import '../../data/{{#snakeCase}}{{feature}}{{/snakeCase}}_repository.dart'; {{#request_model}}
import '../../data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}_request_model.dart';{{/request_model}}
import '../../data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}_response_model.dart';{{#parameters}} {{#custom}} 
import '../../data/model/parameter/{{#snakeCase}}{{parameter}}{{/snakeCase}}.dart'; {{/custom}} {{/parameters}} 

part '{{#snakeCase}}{{name}}{{/snakeCase}}_state.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}Cubit extends Cubit<{{#pascalCase}}{{name}}{{/pascalCase}}State> {
  {{#pascalCase}}{{name}}{{/pascalCase}}Cubit(this._repository) : super(const {{#pascalCase}}{{name}}{{/pascalCase}}State());

  final {{#pascalCase}}{{feature}}{{/pascalCase}}Repository _repository;
  {{#request_model}}RequestModel? requestModel;{{/request_model}}

  Future<void> {{#feature_list}}_{{/feature_list}}{{#camelCase}}{{name}}{{/camelCase}}({{#feature_list}} {required int? page} {{/feature_list}}) async {
    {{#form}}if (!state.isFormValid) return;{{/form}}
    {{#request_model}}final requestModel = {{#pascalCase}}{{name}}{{/pascalCase}}RequestModel({{#form}}{{#parameters}}
    {{#camelCase}}{{parameter}}{{/camelCase}}: state.{{#camelCase}}{{parameter}}{{/camelCase}}!, {{/parameters}}{{/form}} );
    _{{#camelCase}}{{name}}{{/camelCase}}(requestModel);
  }

  Future<void> {{#feature_list}}_{{/feature_list}}_{{#camelCase}}{{name}}{{/camelCase}}({{#pascalCase}}{{name}}{{/pascalCase}}RequestModel requestModel) async {
    this.requestModel = requestModel;{{/request_model}}
    emit(state.requestLoading());
    final result = await _repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}requestModel{{/request_model}});
    emit(
        result.fold((l) => state.requestFailed(l), (r)  { {{#feature_list}}
          if (state.response != null) {
            final newItems = [...state.response!.{{#camelCase}}{{name}}{{/camelCase}}List, ...r.{{#camelCase}}{{name}}{{/camelCase}}List];
            r.{{#camelCase}}{{name}}{{/camelCase}}List.clear();
            r.{{#camelCase}}{{name}}{{/camelCase}}List.addAll(newItems);
          }{{/feature_list}}
          return state.requestSuccess(r);
        }));
  }
  {{#parameters}}
  void {{#camelCase}}{{parameter}}{{/camelCase}}Changed({{#custom}}String{{/custom}}{{^custom}}{{{type}}}{{/custom}} value) {
    emit(state.copyWith({{#camelCase}}{{parameter}}{{/camelCase}}: {{#custom}}{{#pascalCase}}{{{type}}}{{/pascalCase}}({{/custom}}value{{#custom}}){{/custom}}));
  }
  {{/parameters}} 

  void retry() { {{#request_model}}
    if (requestModel is {{#pascalCase}}{{name}}{{/pascalCase}}RequestModel) {
      {{#feature_list}}_{{/feature_list}}_{{#camelCase}}{{name}}{{/camelCase}}(requestModel! as {{#pascalCase}}{{name}}{{/pascalCase}}RequestModel);
    }{{/request_model}}{{^request_model}}{{#camelCase}}{{name}}{{/camelCase}}();{{/request_model}}
  }
  {{#feature_list}}
  void loadNextPage() {
    if (state.loading) return;
    final nextPage = state.response == null
        ? 1
        : state.response!.paginationMeta
            .nextPage(state.response!.{{#camelCase}}{{name}}{{/camelCase}}List.length);
    _{{#camelCase}}{{name}}{{/camelCase}}(page: nextPage);
  }

  Future<void> reload() async {
    emit(state.copyWith(response: Nullable(null)));
    _{{#camelCase}}{{name}}{{/camelCase}}(page: 1);
  }
  {{/feature_list}}
}

//TODO add this to {{#snakeCase}}{{feature}}{{/snakeCase}}_di.dart
..registerFactory(() => {{#pascalCase}}{{name}}{{/pascalCase}}Cubit(di()))