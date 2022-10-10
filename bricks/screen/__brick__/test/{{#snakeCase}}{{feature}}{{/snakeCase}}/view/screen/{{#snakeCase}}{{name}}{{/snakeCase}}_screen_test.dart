import 'dart:async';

import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/data/api_manager.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/app.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/services/loader.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/view/widgets/buttons/app_button.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/di/injection_container.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/l10n/l10n.dart';{{#parameters}}
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/parameter/mock/{{#snakeCase}}{{type}}{{/snakeCase}}_mock.dart'; {{/parameters}}
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/data/model/{{#snakeCase}}{{name}}{{/snakeCase}}/mock/{{#snakeCase}}{{name}}{{/snakeCase}}_response_model_mock.dart';
import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/{{#snakeCase}}{{feature}}{{/snakeCase}}/view/screen/{{#snakeCase}}{{name}}{{/snakeCase}}_screen.dart';

import '../../../core/view/services/alert_test.dart' as alert;
import '../../../core/view/services/generic_error_handler_test.dart' as failure_handler;
import '../../../core/view/services/loader_test.dart' as loader;
import '../../../helper/init_main.dart';
import '../../faker.dart';

Future<void> main() async {
  late Mock{{#pascalCase}}{{feature}}{{/pascalCase}}Repository repository;

  setUpAll(() {
    setupFaker();
    repository = Mock{{#pascalCase}}{{feature}}{{/pascalCase}}Repository();
  });

  group('{{#pascalCase}}{{name}}{{/pascalCase}} page Text fields validations', () {
    setUpAll(() async {
      await initnMock();
    });

    tearDownAll(() async {
      await di.reset();
    });

    testWidgets(
      '''
      Given user entered valid form 
      then submit button should be activated if valid''',
      (WidgetTester tester) async {
        await tester.runAsync(() async {
          // arrange
          late BuildContext buildContext;
          await tester.pumpWidget(
            MainApp(
              home: Builder(
                builder: (context) {
                  buildContext = context;
                  return const {{#pascalCase}}{{name}}{{/pascalCase}}Screen();
                },
              ),
            ),
          );
          await tester.pumpAndSettle();
          //act
          await enterValidForm(tester);
          //assert
          await assertValidForm(tester, buildContext);
        });
      },
    );

    testWidgets(
      '''
      Given user entered invalid form then should shows an error
      and submit button should be inactive''',
      (WidgetTester tester) async {
        await tester.runAsync(() async {
          // arrange
          late BuildContext buildContext;
          await tester.pumpWidget(
            MainApp(
              home: Builder(
                builder: (context) {
                  buildContext = context;
                  return const {{#pascalCase}}{{name}}{{/pascalCase}}Screen();
                },
              ),
            ),
          );
          await tester.pumpAndSettle();
          //act
          await enterInValidForm(tester);
          //assert
          await assertInValidForm(tester, buildContext);
        });
      },
    );

    testWidgets('''
        Given user entered invalid form then valid one
        then should shows an error while invaid and submit button should be activated if valid''',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        // arrange
        late BuildContext buildContext;
        await tester.pumpWidget(
          MainApp(
            home: Builder(
              builder: (context) {
                buildContext = context;
                return const {{#pascalCase}}{{name}}{{/pascalCase}}Screen();
              },
            ),
          ),
        );
        await tester.pumpAndSettle();
        //act
        await enterInValidForm(tester);
        //assert
        await assertInValidForm(tester, buildContext);
        //act
        await enterValidForm(tester);
        //assert
        await assertValidForm(tester, buildContext);
      });
    });
  });

  group('{{#pascalCase}}{{name}}{{/pascalCase}} Action', () {
    setUpAll(() async {
      await initnMock({{#snakeCase}}{{feature}}{{/snakeCase}}Repository: repository);
    });

    tearDownAll(() async {
      await di.reset();
    });

    testWidgets(
      '''
      Given user entered valid and correct form
      When repository returns Right({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModel)
      Then should make the success action''',
      (WidgetTester tester) async {
        await tester.runAsync(() async {
          // arrange
          Loader.newInstance();
          late BuildContext buildContext;
          await tester.pumpWidget(
            MainApp(
              home: Builder(
                builder: (context) {
                  buildContext = context;
                  return const {{#pascalCase}}{{name}}{{/pascalCase}}Screen();
                },
              ),
            ),
          );
          await tester.pumpAndSettle();
          // act
          await enterValidForm(tester);
          // assert
          await assertValidForm(tester, buildContext);
          // arrange
          when(() => repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}any(){{/request_model}})).thenAnswer(
            (_) async => Future.delayed(loadingDuration).then(
              (value) => Right({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock),
            ),
          );
          // act
          await press{{#camelCase}}{{name}}{{/camelCase}}(tester);
          // assert
          await loader.assertLoadingAppeardAndDisAppeared(tester);
          await assertSuccess(tester);
        });
      },
    );

    testWidgets(
      '''
      Given user entered valid but incorrect form
      When repository returns Error failure
      Then error message should be presented''',
      (WidgetTester tester) async {
        await tester.runAsync(() async {
          // arrange
          Loader.newInstance();
          late BuildContext buildContext;
          await tester.pumpWidget(
            MainApp(
              home: Builder(
                builder: (context) {
                  buildContext = context;
                  return const {{#pascalCase}}{{name}}{{/pascalCase}}Screen();
                },
              ),
            ),
          );
          await tester.pumpAndSettle();
          // act
          await enterValidForm(tester);
          // assert
          await assertValidForm(tester, buildContext);
          // arrange
          const errorMessage = 'Failed';
          when(() => repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}any(){{/request_model}})).thenAnswer(
            (_) async => Future.delayed(loadingDuration).then(
              (value) => Left(
                Failures.errorFailure(
                  errorStatus: ErrorStatus.authenticationError,
                  error: MessageResponseModel(message: errorMessage),
                ),
              ),
            ),
          );
          // act
          await press{{#camelCase}}{{name}}{{/camelCase}}(tester);
          // assert
          await loader.assertLoadingAppeardAndDisAppeared(tester);
          await tester.pumpAndSettle();
          await alert.assertAlertShownWithDuration(tester,
              message: errorMessage);
        });
      },
    );

    testWidgets(
      '''
      Given user entered valid form 
      When repository returns ConnectionFailure
      Then Retry Dialog Should be Presented''',
      (WidgetTester tester) async {
        await tester.runAsync(() async {
          // arrange
          reset(repository);
          Loader.newInstance();
          late BuildContext buildContext;
          await tester.pumpWidget(
            MainApp(
              home: Builder(
                builder: (context) {
                  buildContext = context;
                  return const {{#pascalCase}}{{name}}{{/pascalCase}}Screen();
                },
              ),
            ),
          );
          await tester.pumpAndSettle();
          // act
          await enterValidForm(tester);
          // assert
          await assertValidForm(tester, buildContext);
          // arrange
          when(() => repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}any(){{/request_model}})).thenAnswer(
            (_) async => Future.delayed(loadingDuration).then(
              (value) => Left(Failures.connectionFailure()),
            ),
          );
          // act
          await press{{#camelCase}}{{name}}{{/camelCase}}(tester);
          // assert
          await loader.assertLoadingAppeardAndDisAppeared(tester);

          await failure_handler.assertConnectionFailureDialogVisible();
          // arrange
          when(() => repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}any(){{/request_model}})).thenAnswer(
            (_) async => Future.delayed(loadingDuration).then(
              (value) => Right({{#pascalCase}}{{name}}{{/pascalCase}}ResponseModelMock.mock),
            ),
          );
          // act
          await failure_handler.pressRetry(tester);
          await failure_handler.assertConnectionFailureDialogInVisible();
          verify(() => repository.{{#camelCase}}{{name}}{{/camelCase}}({{#request_model}}any(){{/request_model}})).called(2);
        });
      },
    );
  });
}

{{#parameters}}
const _{{#camelCase}}{{parameter}}{{/camelCase}}Key = Key('{{#snakeCase}}{{name}}{{/snakeCase}}_text_field_{{#snakeCase}}{{parameter}}{{/snakeCase}}'); {{/parameters}}
const _{{#camelCase}}{{name}}{{/camelCase}}Key = Key('{{#snakeCase}}{{name}}{{/snakeCase}}_button');

Future<void> enterValidForm(WidgetTester tester) async {
// act {{#parameters}}
  await tester.enterText(find.byKey(_{{#camelCase}}{{parameter}}{{/camelCase}}Key), {{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}); {{/parameters}}
  await tester.pumpAndSettle();
}

Future<void> assertValidForm(
    WidgetTester tester, BuildContext context) async {
  // assert {{#parameters}}
  expect(find.text(context.l10n.invalid_{{#snakeCase}}{{type}}{{/snakeCase}}), findsNothing); {{/parameters}}
  final {{#camelCase}}{{name}}{{/camelCase}}Button = tester.widget<AppButton>(find.byKey(_{{#camelCase}}{{name}}{{/camelCase}}Key));
  expect({{#camelCase}}{{name}}{{/camelCase}}Button.onpressed, isNotNull);
}

Future<void> enterInValidForm(WidgetTester tester) async {
// act {{#parameters}}
  await tester.enterText(find.byKey(_{{#camelCase}}{{parameter}}{{/camelCase}}Key), {{#pascalCase}}{{{type}}}{{/pascalCase}}Mock.{{#camelCase}}{{{type}}}{{/camelCase}}Invalid);
{{/parameters}}
  await tester.pumpAndSettle();
}

Future<void> assertInValidForm(
    WidgetTester tester, BuildContext context) async {
  // assert {{#parameters}}
  expect(find.text(context.l10n.invalid_{{#snakeCase}}{{type}}{{/snakeCase}}), findsOneWidget); {{/parameters}}
  final {{#camelCase}}{{name}}{{/camelCase}}Button = tester.widget<AppButton>(find.byKey(_{{#camelCase}}{{name}}{{/camelCase}}Key));
  expect({{#camelCase}}{{name}}{{/camelCase}}Button.onpressed, isNull);
}

Future<void> press{{#pascal}}{{name}}{{/pascal}}(WidgetTester tester) async {
  //act
  expect(find.byKey(_{{#camelCase}}{{name}}{{/camelCase}}Key), findsOneWidget);
  await tester.tap(find.byKey(_{{#camelCase}}{{name}}{{/camelCase}}Key));
  await tester.pumpAndSettle();
}

//TODO add success condition
Future<void> assertSuccess(WidgetTester tester) async {}

//TODO add this to integration_test/app_test.dart
//!add this line to immports
import '../test/{{#snakeCase}}{{feature}}{{/snakeCase}}/view/screen/{{#snakeCase}}{{name}}{{/snakeCase}}_screen_test.dart' as {{#snakeCase}}{{name}}{{/snakeCase}}_screen;

//!add this line to the end of main
await {{#snakeCase}}{{name}}{{/snakeCase}}_screen.main();
