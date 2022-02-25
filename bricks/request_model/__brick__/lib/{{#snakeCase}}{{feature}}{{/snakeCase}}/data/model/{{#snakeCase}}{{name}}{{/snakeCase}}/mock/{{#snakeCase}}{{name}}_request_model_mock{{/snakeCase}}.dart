 {{#parameters}}{{#custom}}
import '../../parameter/mock/{{#snakeCase}}{{parameter}}{{/snakeCase}}_mock.dart'; {{/custom}} {{/parameters}}
import '../{{#snakeCase}}{{name}}{{/snakeCase}}_request_model.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}RequestModelMock { {{#parameters}}{{^custom}}
  static const {{parameter}}Mock = ;
  {{/custom}}{{/parameters}}
  static final mock = {{#pascalCase}}{{name}}{{/pascalCase}}RequestModel( {{#parameters}}
    {{parameter}}: {{#custom}}{{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}Mock,{{/custom}}{{^custom}} {{parameter}}Mock,
  {{/custom}}{{/parameters}});
  {{#parameters}}{{#custom}}
  //TODO remove Invlaid from all parameter but {{parameter}}
  static final mockInvalid{{#pascalCase}}{{parameter}}{{/pascalCase}} = {{#pascalCase}}{{name}}{{/pascalCase}}RequestModel( {{#parameters}}
    {{parameter}}: {{#custom}}{{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}MockInvalid,{{/custom}}{{^custom}} {{parameter}}Mock,
  {{/custom}}{{/parameters}});
  {{/custom}}{{/parameters}}
}
