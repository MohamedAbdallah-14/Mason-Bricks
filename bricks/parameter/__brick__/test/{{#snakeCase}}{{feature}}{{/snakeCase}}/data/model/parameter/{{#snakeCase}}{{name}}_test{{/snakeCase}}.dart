
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/parameter/mock/{{#snakeCase}}{{name}}_mock{{/snakeCase}}.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/parameter/{{name}}.dart';

void main() {
  group('{{name}} validator', () {
    test('''
given {{name}} class initialized when the value is corret then value should be {{name}}''',
        () async {
      // arrange
      final {{name}} = {{#pascalCase}}{{name}}{{/pascalCase}}({{#pascalCase}}{{name}}{{/pascalCase}}Mock.{{name}});
      // act
      final value = {{name}}.value;
      // assert
      expect(value, const Right({{#pascalCase}}{{name}}{{/pascalCase}}Mock.{{name}}));
    });

    test('''
given {{name}} class initialized when the value is text then value should be ValidtorFailure''',
        () async {
      // arrange
      final {{name}} = {{#pascalCase}}{{name}}{{/pascalCase}}({{#pascalCase}}{{name}}{{/pascalCase}}Mock.{{name}}Invalid);
      // assert
      expect({{name}}.value, Left(ValidationFailure('invalid_{{name}}')));
    });

    test('''
given {{name}} class initialized with error ValidationFailure then value should be ValidtorFailure''',
        () async {
      // arrange
      final {{name}} = {{#pascalCase}}{{name}}{{/pascalCase}}.error(ValidationFailure('error'));
      // assert
      expect({{name}}.value, Left(ValidationFailure('error')));
    });
  });
}
