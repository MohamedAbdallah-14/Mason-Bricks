import '../{{#snakeCase}}{{name}}{{/snakeCase}}.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}Mock {
  //TODO add valid and invalid parameter mock
  static const {{#camelCase}}{{name}}{{/camelCase}} = ;
  static const {{#camelCase}}{{name}}{{/camelCase}}Invalid = ;
  static final {{#camelCase}}{{name}}{{/camelCase}}Mock = {{#pascalCase}}{{name}}{{/pascalCase}}({{#camelCase}}{{name}}{{/camelCase}});
  static final {{#camelCase}}{{name}}{{/camelCase}}MockInvalid = {{#pascalCase}}{{name}}{{/pascalCase}}({{#camelCase}}{{name}}{{/camelCase}}Invalid);
}
