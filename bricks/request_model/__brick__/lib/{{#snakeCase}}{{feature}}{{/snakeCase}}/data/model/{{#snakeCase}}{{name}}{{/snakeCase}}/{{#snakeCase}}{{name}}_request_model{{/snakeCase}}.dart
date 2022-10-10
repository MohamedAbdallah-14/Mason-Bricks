import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/data/api_manager.dart';

{{#parameters}} {{#custom}} 
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/{{#enum}}enum{{/enum}}{{#custom}}parameter{{/custom}}/{{#snakeCase}}{{parameter}}{{/snakeCase}}.dart'; {{/custom}} {{/parameters}} 

class {{#pascalCase}}{{name}}{{/pascalCase}}RequestModel extends RequestModel {
  {{#pascalCase}}{{name}}{{/pascalCase}}RequestModel({ {{#parameters}}
    required this.{{#camelCase}}{{parameter}}{{/camelCase}}, {{/parameters}} 
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  {{#parameters}}
  final {{{type}}}{{#enum}}?{{/enum}} {{#camelCase}}{{parameter}}{{/camelCase}}; {{/parameters}} 

  @override
  Future<Map<String, dynamic>> toMap() async {
    final map = <String, dynamic>{ {{#parameters}} {{^nullable}}
    '{{field}}': {{#camelCase}}{{parameter}}{{/camelCase}}{{#enum}}.value{{/enum}}{{#custom}}.value.fold((l) => throw ValidationException(l.valueKey), (r) => r){{/custom}}, {{/nullable}}{{/parameters}}
    };{{#parameters}} {{#nullable}}
    if({{#camelCase}}{{parameter}}{{/camelCase}} != null){
      map['{{field}}'] = {{#camelCase}}{{parameter}}{{/camelCase}}{{#enum}}.value{{/enum}}{{#custom}}.value.fold((l) => throw ValidationException(l.valueKey), (r) => r){{/custom}};
    } {{/nullable}}{{/parameters}}
    return map;
  }

  @override
  List<Object> get props => [ {{#parameters}}
    {{#camelCase}}{{parameter}}{{/camelCase}}, {{/parameters}}
  ];
}
