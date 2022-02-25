import 'package:zumra/core/data/api_manager.dart';

import 'package:dartz/dartz.dart';

import '../../core/flavors.dart';

class {{#pascalCase}}{{feature}}{{/pascalCase}}Repository {
  {{#pascalCase}}{{feature}}{{/pascalCase}}Repository(this._apIsManager);

  final APIsManager _apIsManager;

}
