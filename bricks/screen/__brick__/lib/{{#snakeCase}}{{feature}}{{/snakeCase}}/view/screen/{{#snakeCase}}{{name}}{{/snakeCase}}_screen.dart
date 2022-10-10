import 'dart:developer';

import 'package:{{#snakeCase}}{{app}}{{/snakeCase}}/core/data/api_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/alert.dart';
import '../../../core/services/generic_error_handler.dart';
import '../../../core/services/loader.dart';
import '../../../core/view/widgets/buttons/app_button.dart';
import '../../../core/view/widgets/text_fields/app_text_field.dart';
import '../../../di/injection_container.dart';
import '../../../l10n/l10n.dart';
import '../../logic/{{#snakeCase}}{{name}}{{/snakeCase}}/{{#snakeCase}}{{name}}{{/snakeCase}}_cubit.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}Screen extends StatelessWidget {
  const {{#pascalCase}}{{name}}{{/pascalCase}}Screen({Key? key}) : super(key: key);

  static const id = '/{{#paramCase}}{{name}}{{/paramCase}}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => di<{{#pascalCase}}{{name}}{{/pascalCase}}Cubit>(),
        child: const _Page(),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<{{#pascalCase}}{{name}}{{/pascalCase}}Cubit, {{#pascalCase}}{{name}}{{/pascalCase}}State>(
          listenWhen: (previous, current) =>
              previous.loading != current.loading,
          listener: (context, state) {
            state.loading
                ? Loader.instance.show(context)
                : Loader.instance.hide();
          },
        ),
        BlocListener<{{#pascalCase}}{{name}}{{/pascalCase}}Cubit, {{#pascalCase}}{{name}}{{/pascalCase}}State>(
          listenWhen: (previous, current) =>
              previous.response != current.response ||
              previous.failure != current.failure,
          listener: (context, state) {
            if (state.response != null) {
              //TODO add success logic
              log('Success');
              log(state.response.toString());
            }
            final failure = state.failure;
            if (failure is ErrorFailure) {
              final error = failure.error;
              if (error is MessageResponseModel) {
                Alert.instance.error(context, error.message);
              }
            } else if (failure != null) {
              GenraicErrorHandler.instance.handle(
                failure: failure,
                onRetry: () => context.read<{{#pascalCase}}{{name}}{{/pascalCase}}Cubit>().retry(),
                context: context,
              );
            }
          },
        ),
      ],
      child:{{#form}} Form(
        child: Column(
          children: [
            const SizedBox(height: 30), {{#parameters}}            
            BlocBuilder<{{#pascalCase}}{{name}}{{/pascalCase}}Cubit, {{#pascalCase}}{{name}}{{/pascalCase}}State>(
              buildWhen: (previous, current) =>
                  previous.{{parameter}} != current.{{parameter}},
              builder: (context, state) {
                return AppTextField(
                  key: const Key('{{#snakeCase}}{{name}}{{/snakeCase}}_text_field_{{#snakeCase}}{{parameter}}{{/snakeCase}}'),
                  labelKey: context.l10n.{{#snakeCase}}{{parameter}}{{/snakeCase}},
                  onChanged: (value) =>
                      context.read<{{#pascalCase}}{{name}}{{/pascalCase}}Cubit>().{{parameter}}Changed(value),
                  validator: (string) => state.{{parameter}}?.value
                      .fold((l) => context.translate(l.valueKey), (r) => null),
                );
              },
            ),{{/parameters}}
            BlocBuilder<{{#pascalCase}}{{name}}{{/pascalCase}}Cubit, {{#pascalCase}}{{name}}{{/pascalCase}}State>(
              buildWhen: (previous, current) =>
                  previous.isFormValid != current.isFormValid,
              builder: (context, state) {
                return AppButton(
                  key: const Key('{{#snakeCase}}{{name}}{{/snakeCase}}_button'),
                  textKey: context.l10n.{{#snakeCase}}{{name}}{{/snakeCase}},
                  onpressed: state.isFormValid ? () => {{#camelCase}}{{name}}{{/camelCase}}(context) : null,
                );
              },
            ),
          ],
        ),
      ),{{/form}} {{^form}} Container() {{/form}}
    );
  }

  void {{#camelCase}}{{name}}{{/camelCase}}(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<{{#pascalCase}}{{name}}{{/pascalCase}}Cubit>().{{#camelCase}}{{name}}{{/camelCase}}();
  }
}
