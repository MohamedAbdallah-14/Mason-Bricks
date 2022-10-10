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

class {{#pascalCase}}{{name}}{{/pascalCase}}ListScreen extends StatelessWidget {
  const {{#pascalCase}}{{name}}{{/pascalCase}}ListScreen({Key? key}) : super(key: key);

  static const id = '/{{#paramCase}}{{name}}{{/paramCase}}-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => di<{{#pascalCase}}{{name}}{{/pascalCase}}ListCubit>(),
        child: const _Page(),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({Key? key}) : super(key: key);

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Loader.instance.show(context);
      context.read<{{#pascalCase}}{{name}}{{/pascalCase}}ListCubit>().loadNextPage();
    });
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter <= 0) {
      context.read<{{#pascalCase}}{{name}}{{/pascalCase}}ListCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<{{#pascalCase}}{{name}}{{/pascalCase}}ListCubit, {{#pascalCase}}{{name}}{{/pascalCase}}State>(
          listenWhen: (previous, current) =>
              previous.loading != current.loading,
          listener: (context, state) {
            state.loading
                ? Loader.instance.show(context)
                : Loader.instance.hide();
            // if (!state.loading &&
            //     (state.response?.paginationMeta.page ?? 1) > 1) {
            //   scrollController.animateTo(
            //     scrollController.position.pixels + 150,
            //     duration: const Duration(milliseconds: 500),
            //     curve: Curves.easeIn,
            //   );
            // }
          },
        ),

        BlocListener<{{#pascalCase}}{{name}}{{/pascalCase}}ListCubit, {{#pascalCase}}{{name}}{{/pascalCase}}State>(
          listenWhen: (previous, current) =>
              previous.failure != current.failure,
          listener: (context, state) {
            final failure = state.failure;
             if (failure != null) {
              GenraicErrorHandler.instance.handle(
                failure: failure,
                onRetry: () => context.read<{{#pascalCase}}{{name}}{{/pascalCase}}ListCubit>().retry(),
                context: context,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<{{#pascalCase}}{{name}}{{/pascalCase}}ListCubit, {{#pascalCase}}{{name}}{{/pascalCase}}State>(
        builder: (context, state) {
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              context.read<{{#pascalCase}}{{name}}{{/pascalCase}}ListCubit>().reload();
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.response?.{{#camelCase}}{{name}}{{/camelCase}}List.length ?? 0,
              itemBuilder: (context, index) => {{#pascalCase}}{{cell_name}}{{/pascalCase}}Cell(
                {{#camelCase}}{{name}}{{/camelCase}}: state.response?.{{#camelCase}}{{name}}{{/camelCase}}[index],
              ),
            ),
          );
        },
      ),
    );
  }

  void {{#camelCase}}{{name}}{{/camelCase}}(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<{{#pascalCase}}{{name}}{{/pascalCase}}ListCubit>().loadNextPage();

  }
}
