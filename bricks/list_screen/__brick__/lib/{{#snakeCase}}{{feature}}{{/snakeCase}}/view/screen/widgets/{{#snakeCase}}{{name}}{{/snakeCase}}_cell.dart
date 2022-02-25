import 'package:flutter/material.dart';

import '../../../../data/model/{{#camelCase}}{{name}}{{/camelCase}}/{{#camelCase}}{{name}}{{/camelCase}}.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}Cell extends StatelessWidget {
  const {{#pascalCase}}{{name}}{{/pascalCase}}Cell({Key? key, required this.{{#camelCase}}{{name}}{{/camelCase}}}) : super(key: key);

  final {{#pascalCase}}{{name}}{{/pascalCase}}? {{#camelCase}}{{name}}{{/camelCase}};

  @override
  Widget build(BuildContext context) {
    if ({{#camelCase}}{{name}}{{/camelCase}} == null) return Container();
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          {{#pascalCase}}{{name}}{{/pascalCase}}DetailsScreen.id,
          arguments: {{#camelCase}}{{name}}{{/camelCase}},
        );
      },
      child: Card(),
    );
  }
}
