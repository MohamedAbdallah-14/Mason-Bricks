enum {{#pascalCase}}{{name}}{{/pascalCase}} { {{#parameters}} {{#camelCase}}{{parameter}}{{/camelCase}}, {{/parameters}} }

extension {{#pascalCase}}{{name}}{{/pascalCase}}Extension on {{#pascalCase}}{{name}}{{/pascalCase}} {
  String get value {
    switch (this) { {{#parameters}} 
      case {{#pascalCase}}{{name}}{{/pascalCase}}.{{#camelCase}}{{parameter}}{{/camelCase}} :
        return '{{#camelCase}}{{parameter}}{{/camelCase}}';{{/parameters}}
    }
  }

  static {{#pascalCase}}{{name}}{{/pascalCase}} parse(String? value) {
    switch (value) { {{#parameters}} 
      case '{{#camelCase}}{{parameter}}{{/camelCase}}':
        return {{#pascalCase}}{{name}}{{/pascalCase}}.{{#camelCase}}{{parameter}}{{/camelCase}} ; {{/parameters}} 
      default:
        return ;
    }
  }
}
