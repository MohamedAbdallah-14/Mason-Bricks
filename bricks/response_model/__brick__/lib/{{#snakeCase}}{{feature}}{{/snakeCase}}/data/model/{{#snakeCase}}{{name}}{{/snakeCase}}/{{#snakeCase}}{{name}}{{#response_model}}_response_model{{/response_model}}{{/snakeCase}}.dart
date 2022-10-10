import 'package:equatable/equatable.dart';
{{#response_model}}import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/data/api_manager.dart';{{/response_model}}

class {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}} extends Equatable {{#response_model}}implements ResponseModel {{/response_model}}{
  const {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}}({ {{#parameters}}
    required this.{{parameter}}, {{/parameters}} 
  });

  factory {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}}.fromMap(Map<String, dynamic> map) {
    return {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}}( {{#parameters}} 
      {{parameter}}:{{#enum}}{{#pascalCase}}{{type}}{{/pascalCase}}Extension.parse(map{{#paths}}['{{path}}']{{/paths}}['{{field}}']),{{/enum}} {{^list}}{{#custom}}{{{type}}}.fromMap({{/custom}}{{/list}}{{^custom}}{{#list}}List<{{{type}}}>.from({{/list}}{{/custom}}{{#list}}{{#custom}}List<{{{type}}}>.from({{/custom}}{{/list}}map{{#paths}}['{{path}}']{{/paths}}['{{field}}']{{^list}}{{#custom}}){{/custom}}{{/list}}{{^custom}}{{#list}}){{/list}}{{/custom}}{{#list}}{{#custom}}?.map((x) => {{{type}}}.fromMap(x))){{/custom}}{{/list}}, {{#list}}{{#paths}}//TODO check for null parent `map['path'] == null ? [] :`{{/paths}}{{/list}} {{/parameters}}
    );
  }

  {{#parameters}}
  final {{#list}}List<{{/list}}{{{type}}}{{#list}}>{{/list}} {{parameter}}; {{/parameters}} 

  Map<String, dynamic> toMap() => { {{#parameters}}
    {{#paths}} '{{path}}': {
    {{/paths}}'{{field}}': {{parameter}}{{#enum}}.value{{/enum}}{{^list}}{{#custom}}.toMap(){{/custom}}{{/list}}{{#list}}{{#custom}}.map((x) => x.toMap()).toList(){{/custom}}{{/list}} {{#paths}},} {{/paths}}, {{/parameters}}
    };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ {{#parameters}}
    {{parameter}}, {{/parameters}}
  ];
}