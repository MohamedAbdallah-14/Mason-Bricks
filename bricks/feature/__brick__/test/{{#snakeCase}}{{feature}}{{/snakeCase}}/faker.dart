import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/data/api_manager.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/{{#snakeCase}}{{feature}}{{/snakeCase}}_repository.dart';

class MockAPIsManager extends Mock implements APIsManager {}

class Mock{{#pascalCase}}{{feature}}{{/pascalCase}}Repository extends Mock implements {{#pascalCase}}{{feature}}{{/pascalCase}}Repository {}

class RequestFake extends Fake implements Request {}

void setupFaker() {
  registerFallbackValue<Request>(RequestFake());
}
