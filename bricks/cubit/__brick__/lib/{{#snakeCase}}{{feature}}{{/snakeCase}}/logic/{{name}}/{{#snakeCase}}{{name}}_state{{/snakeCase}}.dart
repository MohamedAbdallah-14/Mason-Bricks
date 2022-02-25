part of '{{#snakeCase}}{{name}}{{/snakeCase}}_cubit.dart';

@immutable
class {{#pascalCase}}{{name}}{{/pascalCase}}State extends Equatable {
  const {{#pascalCase}}{{name}}{{/pascalCase}}State({
    this.loading = false,
    this.failure,
    this.response,{{#parameters}}
    this.{{#camelCase}}{{parameter}}{{/camelCase}}, {{/parameters}}
  });

  final bool loading;
  final Failure? failure;
  final {{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel? response; {{#parameters}}
  final {{{type}}}? {{#camelCase}}{{parameter}}{{/camelCase}}; {{/parameters}} 
  {{#form}}
  bool get isFormValid => {{#parameters}} {{#custom}}
      ({{#camelCase}}{{parameter}}{{/camelCase}}?.value.isRight() ?? false) && {{/custom}}{{/parameters}}; {{/form}}

  {{#pascalCase}}{{name}}{{/pascalCase}}State requestSuccess({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel response) =>
      copyWith(loading: false, response: Nullable(response));

  {{#pascalCase}}{{name}}{{/pascalCase}}State requestFailed(Failure failure) =>
      copyWith(loading: false, failure: Nullable(failure));

  {{#pascalCase}}{{name}}{{/pascalCase}}State requestLoading() =>
      copyWith(loading: true, failure: Nullable(null), response: Nullable(null));

  {{#pascalCase}}{{name}}{{/pascalCase}}State copyWith({
    bool? loading,
    Nullable<Failure?>? failure,
    Nullable<{{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel?>? response,
    {{#parameters}}
    {{{type}}}? {{#camelCase}}{{parameter}}{{/camelCase}}, {{/parameters}}
  }) {
    return {{#pascalCase}}{{name}}{{/pascalCase}}State(
      loading: loading ?? this.loading,
      failure: failure == null ? this.failure : failure.value,
      response: response == null ? this.response : response.value,{{#parameters}}
      {{#camelCase}}{{parameter}}{{/camelCase}}: {{#camelCase}}{{parameter}}{{/camelCase}} ?? this.{{#camelCase}}{{parameter}}{{/camelCase}}, {{/parameters}}
    );
  }

  @override
  List<Object?> get props => [loading, failure, response, {{#parameters}}{{#camelCase}}{{parameter}}{{/camelCase}}, {{/parameters}}];

  @override
  bool get stringify => true;
}
