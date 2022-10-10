import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/data/api_manager.dart';

{{#request_model}}import '../model/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}_request_model.dart';{{/request_model}}

class {{#pascalCase}}{{name}}{{/pascalCase}}Request with Request,{{#get}}Get{{/get}}{{#post}}Post{{/post}}{{#put}}Put{{/put}}{{#delete}}Delete{{/delete}}Request {
  const {{#pascalCase}}{{name}}{{/pascalCase}}Request({{#request_model}}this.requestModel{{/request_model}});
  {{#request_model}}
  @override
  final {{#pascalCase}}{{name}}{{/pascalCase}}RequestModel requestModel;
  {{/request_model}}
  {{#exclude_token}}
  @override
  bool get includeAuthorization => false;
  {{/exclude_token}} 
  {{#delete}}
  @override
  Future<Map<String, dynamic>?> get queryParameters async => {};
  {{/delete}}
  @override
  String get path => '{{{path}}}{{#request_model}}{{#delete}}/${requestModel.id}{{/delete}}{{/request_model}}';
}

