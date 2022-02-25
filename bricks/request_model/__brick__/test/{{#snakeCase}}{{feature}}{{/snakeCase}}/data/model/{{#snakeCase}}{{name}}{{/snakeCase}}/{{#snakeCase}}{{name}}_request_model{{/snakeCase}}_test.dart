
import 'package:flutter_test/flutter_test.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/mock/{{#snakeCase}}{{name}}{{/snakeCase}}_request_model_mock.dart';{{#parameters}}{{#custom}} 
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/parameter/mock/{{#snakeCase}}{{{type}}}{{/snakeCase}}_mock.dart'; {{/custom}} {{/parameters}} 

void main() {
  test(
    '''
{{#pascalCase}}{{name}}{{/pascalCase}}RequestModel toMap should have the the right parameters''',
    () async {
      /*act*/
      final map = await {{#pascalCase}}{{name}}{{/pascalCase}}RequestModelMock.mock.toMap();
      /*assert*/{{#parameters}}
      expect(map['{{field}}'], {{#custom}}{{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}{{/custom}}{{^custom}} {{#pascalCase}}{{name}}{{/pascalCase}}RequestModelMock.{{parameter}}Mock{{/custom}});{{/parameters}}
    },
  );

  {{#parameters}}{{#custom}}
  test(
    '''
{{#pascalCase}}{{name}}{{/pascalCase}}RequestModel toMap should throw ValidationException if {{parameter}} is not valid''',
    () async {
      expect({{#pascalCase}}{{name}}{{/pascalCase}}RequestModelMock.mockInvalid{{#pascalCase}}{{parameter}}{{/pascalCase}}.toMap(),
          throwsA(
          predicate(
              (e) => e is ValidationException && e.value == 'invalid_{{#snakeCase}}{{{type}}}{{/snakeCase}}'),
        ),
      );
    },
  );
  {{/custom}}{{/parameters}}

}
