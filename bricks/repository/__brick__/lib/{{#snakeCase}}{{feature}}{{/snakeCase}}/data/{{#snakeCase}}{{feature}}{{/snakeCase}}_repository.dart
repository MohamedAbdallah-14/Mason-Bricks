{{#request_model}}
import 'model/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}_request_model.dart';{{/request_model}}
import 'model/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}_response_model.dart';
import 'model/{{#snakeCase}}{{name}}{{/snakeCase}}/mock/{{#snakeCase}}{{name}}{{/snakeCase}}_response_model_mock.dart';
import 'request/{{#snakeCase}}{{name}}{{/snakeCase}}_request.dart';

  Future<Either<Failure, {{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel>> {{#camelCase}}{{name}}{{/camelCase}}(
      {{#request_model}}{{#pascalCase}}{{name}}{{/pascalCase}}RequestModel requestModel{{/request_model}}) async {

    if (mockEnvironment) {
      return Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => Right(
          testMode
              ? {{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock
              :{{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.random,
              ),
      );
    } else {
      final response = await _apIsManager.send(
        request: {{^request_model}}const{{/request_model}} {{#pascalCase}}{{name}}{{/pascalCase}}Request({{#request_model}}requestModel{{/request_model}}),
        responseFromMap: (map) => {{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel.fromMap(map),
      );
      return response;
    }
  }

