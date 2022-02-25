import 'package:flutter_test/flutter_test.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{feature}}/data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}{{#response_model}}_response_model{{/response_model}}.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{feature}}/data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/mock/{{#snakeCase}}{{name}}{{/snakeCase}}{{#response_model}}_response_model{{/response_model}}_mock.dart';

void main() {
  test('{{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}} should be able to convert from and to json',
      () async {
    // arrange
    final json = {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}}Mock.mock.toMap();
    // act
    final {{#camelCase}}{{name}}{{/camelCase}} = {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}}.fromMap(json);
    // assert
    expect({{#camelCase}}{{name}}{{/camelCase}}, {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}}Mock.mock);
  });
}