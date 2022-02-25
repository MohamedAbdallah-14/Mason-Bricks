import 'package:flutter/material.dart';

class {{#pascalCase}}{{feature}}{{/pascalCase}}Router {
  {{#pascalCase}}{{feature}}{{/pascalCase}}Router._();
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      default:
        return null;
    }
  }
}


//TODO remove all below
/*************************************************************lib/app_router.dart*************************************************************/
//TODO add these to lib/app_router.dart

import '{{#snakeCase}}{{feature}}{{/snakeCase}}/view/router.dart';

class AppRouter {
  AppRouter._(); 
  static Route onGenerateRoute(RouteSettings routeSettings) {
    return CoreRouter.onGenerateRoute(routeSettings) ??
    //TODO add this line
    {{#pascalCase}}{{feature}}{{/pascalCase}}Router.onGenerateRoute(routeSettings) ??
        MaterialPageRoute(builder: (_) => const Splash());
  }
}