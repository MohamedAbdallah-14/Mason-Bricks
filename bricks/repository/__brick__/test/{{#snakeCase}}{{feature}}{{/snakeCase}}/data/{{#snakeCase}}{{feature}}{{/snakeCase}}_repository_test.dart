import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}_response_model.dart';{{#request_model}}
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/mock/{{#snakeCase}}{{name}}{{/snakeCase}}_request_model_mock.dart';{{/request_model}}
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/mock/{{#snakeCase}}{{name}}{{/snakeCase}}_response_model_mock.dart';


group('{{#pascalCase}}{{name}}{{/pascalCase}}', () {
  test('''
should return Right({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel) when data apimanger return valid data ''',
      () async {
    // arrange
    when(() => apIsManager.send<{{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel, MessageResponseModel>(
          request: any(named: 'request'),
          responseFromMap: any(named: 'responseFromMap'),
        )).thenAnswer((_) async => Right({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock));
    // act
    final result =
        await repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}{{#pascalCase}}{{name}}{{/pascalCase}}RequestModelMock.mock{{/request_model}});
    // assert
    expect(result, Right({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock));
  });

  test('''
should return Left(ValidationError, MessageResponseModel) when data apimanger return invalid data ''',
      () async {
    // arrange
    final failure = ErrorFailure(
        errorStatus: ErrorStatus.validationError,
        error: MessageResponseModel(message: 'error'));
    when(() => apIsManager.send<{{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel, MessageResponseModel>(
            request: any(named: 'request'),
            responseFromMap: any(named: 'responseFromMap')))
        .thenAnswer((_) async => Left(failure));
    // act
    final result =
        await repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}{{#pascalCase}}{{name}}{{/pascalCase}}RequestModelMock.mock{{/request_model}});
    // assert
    expect(result, Left(failure));
  });

  test('''
should return Left(ServiceNotAvailableFailure) when data apimanger throws server exception''',
      () async {
    // arrange
    when(() => apIsManager.send<{{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel, MessageResponseModel>(
            request: any(named: 'request'),
            responseFromMap: any(named: 'responseFromMap')))
        .thenAnswer((_) async =>  Left(
          ServiceNotAvailableFailure(
            FailureInfo(),
          ),
        ));
    // act
    final result =
        await repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}{{#pascalCase}}{{name}}{{/pascalCase}}RequestModelMock.mock{{/request_model}});
    dynamic value;
    result.fold((l) => value = l, (r) => value = r);
    // assert
    expect(value, isA<ServiceNotAvailableFailure>());
  });
});

/*******************************************group 'Mock Repository'*******************************************************/

test('Should return {{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel when {{#camelCase}}{{name}}{{/camelCase}} called', () async {
  final response =
      await repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}{{#pascalCase}}{{name}}{{/pascalCase}}RequestModelMock.mock{{/request_model}});
  expect(response, Right({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock));
});