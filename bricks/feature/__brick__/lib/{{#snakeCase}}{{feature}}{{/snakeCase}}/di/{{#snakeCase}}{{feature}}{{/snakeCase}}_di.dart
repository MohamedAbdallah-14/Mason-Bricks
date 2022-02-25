import 'package:get_it/get_it.dart';

import '../data/{{#snakeCase}}{{feature}}{{/snakeCase}}_repository.dart';

class {{#pascalCase}}{{feature}}{{/pascalCase}}DI {
  {{#pascalCase}}{{feature}}{{/pascalCase}}DI(this.di, { {{#pascalCase}}{{feature}}{{/pascalCase}}Repository? repository}) {
    call(repository);
  }

  final GetIt di;

  void call({{#pascalCase}}{{feature}}{{/pascalCase}}Repository? repository) {
    di.registerFactory(
          () => repository ?? {{#pascalCase}}{{feature}}{{/pascalCase}}Repository(di()),
      );
  }
}
//TODO remove all below
/*************************************************************lib/di/injection_container.dart*************************************************************/
//TODO add these to lib/di/injection_container.dart

import '../../{{#snakeCase}}{{feature}}{{/snakeCase}}/di/{{#snakeCase}}{{feature}}{{/snakeCase}}_di.dart';
import '../{{#snakeCase}}{{feature}}{{/snakeCase}}/data/{{#snakeCase}}{{feature}}{{/snakeCase}}_repository.dart';

void initDependencyInjection({
  //TODO add this line
  {{#pascalCase}}{{feature}}{{/pascalCase}}Repository? {{feature}}Repository,
  }) {
  //TODO add this line
  {{#pascalCase}}{{feature}}{{/pascalCase}}DI(di, repository: {{feature}}Repository);
}
