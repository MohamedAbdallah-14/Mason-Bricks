
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/mock/{{#snakeCase}}{{name}}{{/snakeCase}}_response_model_mock.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/logic/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}_cubit.dart';{{#parameters}} {{#custom}} 
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/parameter/{{#snakeCase}}{{{type}}}{{/snakeCase}}.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/parameter/mock/{{#snakeCase}}{{type}}_mock{{/snakeCase}}.dart'; {{/custom}} {{/parameters}} 

import '../../faker.dart';

void main() {
  late {{#pascalCase}}{{name}}{{/pascalCase}}Cubit {{#camelCase}}{{name}}{{/camelCase}}Cubit;
  late Mock{{#pascalCase}}{{feature}}{{/pascalCase}}Repository repository;
  {{#request_model}}
  setUpAll(setupFaker);{{/request_model}}

  setUp(() {
    repository = Mock{{#pascalCase}}{{feature}}{{/pascalCase}}Repository();
    {{#camelCase}}{{name}}{{/camelCase}}Cubit = {{#pascalCase}}{{name}}{{/pascalCase}}Cubit(repository);
  });

  test('Initial state loading should be false', () {
    expect({{#camelCase}}{{name}}{{/camelCase}}Cubit.state, const {{#pascalCase}}{{name}}{{/pascalCase}}State());
  });
{{#form}}{{#parameters}}{{#custom}} 
  blocTest(
    '''
{{#camelCase}}{{parameter}}{{/camelCase}}Changed should instantiate new instance of {{#pascalCase}}{{#camelCase}}{{parameter}}{{/camelCase}}{{/pascalCase}} into state and invalid form''',
    build: () => {{#camelCase}}{{name}}{{/camelCase}}Cubit,
    act: ({{#pascalCase}}{{name}}{{/pascalCase}}Cubit cubit) => cubit.{{#camelCase}}{{parameter}}{{/camelCase}}Changed('1'),
    expect: () =>
        [{{#pascalCase}}{{name}}{{/pascalCase}}State({{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{type}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}Invalid))],
    verify: ({{#pascalCase}}{{name}}{{/pascalCase}}Cubit cubit) {
      expect(cubit.state.isFormValid, false);
    },
  );
{{/custom}}{{/parameters}}

  blocTest(
    '''
{{#parameters}}{{#custom}}{{#camelCase}}{{parameter}}{{/camelCase}} and {{/custom}}{{/parameters}}changed should emit state with isValidForm true is all are valid''',
    build: () => {{#camelCase}}{{name}}{{/camelCase}}Cubit,
    act: ({{#pascalCase}}{{name}}{{/pascalCase}}Cubit cubit) => cubit {{#form}}{{#parameters}}{{#custom}} 
      ..{{#camelCase}}{{parameter}}{{/camelCase}}Changed({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}){{/custom}}{{/parameters}}{{/form}}
      ,
    expect: () => [
      //TODO state parameters should be hierarchy exmaple state(email) state(email,password) state(email,password,phonenumber) {{#form}}{{#parameters}}{{#custom}} 
      {{#pascalCase}}{{name}}{{/pascalCase}}State({{#form}}{{#parameters}}{{#custom}}{{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}{{/form}}), {{/custom}}{{/parameters}}{{/form}}
    ],
    verify: ({{#pascalCase}}{{name}}{{/pascalCase}}Cubit cubit) {
      expect(cubit.state.isFormValid, true);
    },
  );
{{/form}}
  blocTest(
    '''
{{name}} should emit lodaing then emit succes when repository returns Right''',
    setUp: () {
     when(() => repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}any(){{/request_model}}))
          .thenAnswer((_) async => Right({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock));
    },
    build: () => {{#camelCase}}{{name}}{{/camelCase}}Cubit,{{#form}}
    seed: () => {{#pascalCase}}{{name}}{{/pascalCase}}State({{#parameters}}{{#custom}}{{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}),{{/form}}
    act: ({{#pascalCase}}{{name}}{{/pascalCase}}Cubit cubit) => cubit.{{#camelCase}}{{name}}{{/camelCase}}(),
    expect: () => [
      {{^request_model}}const {{/request_model}}{{#pascalCase}}{{name}}{{/pascalCase}}State(loading: true, {{#parameters}}{{#custom}}
      {{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}
      ),
      {{#pascalCase}}{{name}}{{/pascalCase}}State({{#parameters}}{{#custom}}
      {{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}
      response: {{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock,
      ),
    ],
  );

  blocTest(
    '''
{{name}} should emit lodaing then emit failure when repository returns Left''',
    setUp: () {
     when(() => repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}any(){{/request_model}}))
          .thenAnswer((_) async => Left(ConnectionFailure()));
    },
    build: () => {{#camelCase}}{{name}}{{/camelCase}}Cubit,{{#form}}
    seed: () => {{#pascalCase}}{{name}}{{/pascalCase}}State({{#parameters}}{{#custom}}{{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}),{{/form}}
    act: ({{#pascalCase}}{{name}}{{/pascalCase}}Cubit cubit) => cubit.{{#camelCase}}{{name}}{{/camelCase}}(),
    expect: () => [
      {{^request_model}}const {{/request_model}}{{#pascalCase}}{{name}}{{/pascalCase}}State(loading: true, {{#parameters}}{{#custom}}
      {{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}
      ),
      {{#pascalCase}}{{name}}{{/pascalCase}}State({{#parameters}}{{#custom}}
      {{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}
      failure: ConnectionFailure(),
      ),
    ],
  );

  blocTest(
    '''
Given current state is failure when {{name}} called and repository returns Right then emit loading true then false with success and no failure''',
    setUp: () {
     when(() => repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}any(){{/request_model}}))
          .thenAnswer((_) async => Right({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock));
    },
    build: () => {{#camelCase}}{{name}}{{/camelCase}}Cubit,
    seed: () => {{#pascalCase}}{{name}}{{/pascalCase}}State( {{#parameters}}{{#custom}}
      {{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}
        failure: ConnectionFailure(),
        ),
    act: ({{#pascalCase}}{{name}}{{/pascalCase}}Cubit cubit) => cubit.{{#camelCase}}{{name}}{{/camelCase}}(),
    expect: () => [
      {{^request_model}}const {{/request_model}}{{#pascalCase}}{{name}}{{/pascalCase}}State(loading: true, {{#parameters}}{{#custom}}
      {{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}
      ),
      {{#pascalCase}}{{name}}{{/pascalCase}}State({{#parameters}}{{#custom}}
      {{#camelCase}}{{parameter}}{{/camelCase}}: {{#pascalCase}}{{{type}}}{{/pascalCase}}({{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}),{{/custom}}{{/parameters}}
      response: {{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock,
      ),
    ],
  );
}
