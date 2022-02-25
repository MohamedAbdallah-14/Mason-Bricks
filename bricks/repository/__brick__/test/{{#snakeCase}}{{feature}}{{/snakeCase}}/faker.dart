{{#request_model}}
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}_request_model.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}RequestModelFake extends Fake implements {{#pascalCase}}{{name}}{{/pascalCase}}RequestModel {}

registerFallbackValue<{{#pascalCase}}{{name}}{{/pascalCase}}RequestModel>({{#pascalCase}}{{name}}{{/pascalCase}}RequestModelFake());
{{/request_model}}