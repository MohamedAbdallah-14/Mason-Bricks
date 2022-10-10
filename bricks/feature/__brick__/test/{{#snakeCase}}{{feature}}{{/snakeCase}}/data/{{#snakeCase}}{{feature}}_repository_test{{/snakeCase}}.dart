import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/data/api_manager.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/flavors.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/{{#snakeCase}}{{feature}}{{/snakeCase}}_repository.dart';

import '../faker.dart';


void main() {
  late {{#pascalCase}}{{feature}}{{/pascalCase}}Repository repository;
  late MockAPIsManager apIsManager;

  setUpAll(() {
    setupFaker();
  });

  setUp(() {
    AppFlavor.appFlavor = Flavors.development;
    apIsManager = MockAPIsManager();
    repository = {{#pascalCase}}{{feature}}{{/pascalCase}}Repository(apIsManager);
  });


  group('Mock Repository', () {
    setUp(() {
      AppFlavor.appFlavor = Flavors.mock;
    });
    
  });
}


//TODO add to init_main.dart

Future<void> initnMock({
  bool integrationTest = false,
  //TODO add this line
  {{#pascalCase}}{{feature}}{{/pascalCase}}Repository? {{#snakeCase}}{{feature}}{{/snakeCase}}Repository,
})

initDependencyInjection(
  //TODO add this line
    {{#snakeCase}}{{feature}}{{/snakeCase}}Repository: {{#snakeCase}}{{feature}}{{/snakeCase}}Repository,
  );