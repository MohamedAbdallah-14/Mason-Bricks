
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}} extends Equatable {
  factory {{#pascalCase}}{{name}}{{/pascalCase}}(String value) => {{#pascalCase}}{{name}}{{/pascalCase}}._(_validate{{#pascalCase}}{{name}}{{/pascalCase}}(value));
  factory {{#pascalCase}}{{name}}{{/pascalCase}}.error(ValidationFailure failure) => {{#pascalCase}}{{name}}{{/pascalCase}}._(Left(failure));

  const {{#pascalCase}}{{name}}{{/pascalCase}}._(this.value);

  final Either<ValidationFailure, String> value;
  
  static Either<ValidationFailure, String> _validate{{#pascalCase}}{{name}}{{/pascalCase}}(String value) {
    //TODO add your validation logic
    if (value.length > 8) return Right(value);

    return Left(ValidationFailure('invalid_{{name}}'));
  }

  @override
  List<Object> get props => [value];
}