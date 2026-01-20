// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main() async {
  // -------- Helpers --------
  String snake(String input) =>
      input.trim().replaceAll(' ', '_').replaceAll('-', '_').toLowerCase();

  String pascalFromSnake(String snakeName) {
    final parts = snakeName.split('_').where((e) => e.isNotEmpty).toList();
    return parts.map((e) => e[0].toUpperCase() + e.substring(1)).join();
  }

  Future<void> ensureDir(String path) async {
    await Directory(path).create(recursive: true);
  }

  Future<void> ensureIndexFile(String path) async {
    final f = File(path);
    if (!await f.exists()) {
      await f.create(recursive: true);
      await f.writeAsString('');
    }
  }

  Future<void> upsertExport({
    required String indexPath,
    required String exportLine,
  }) async {
    await ensureIndexFile(indexPath);
    final file = File(indexPath);
    final content = await file.readAsString();
    final lines = content
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();

    lines.add(exportLine);

    lines.sort((a, b) {
      final aKey = a.contains("'") ? a.substring(a.indexOf("'") + 1) : a;
      final bKey = b.contains("'") ? b.substring(b.indexOf("'") + 1) : b;
      return aKey.compareTo(bKey);
    });

    await file.writeAsString('${lines.join('\n')}\n');
  }

  // -------- Inputs --------
  print('Enter feature name (e.g. settings, expenses):');
  String? featureNameInput = stdin.readLineSync(encoding: utf8);
  if (featureNameInput == null || featureNameInput.trim().isEmpty) {
    print("Feature name can't be empty.");
    return;
  }

  print('Enter screen name (snake_case) (e.g. settings, add_expense):');
  String? screenNameInput = stdin.readLineSync(encoding: utf8);
  if (screenNameInput == null || screenNameInput.trim().isEmpty) {
    print("Screen name can't be empty.");
    return;
  }

  final featureName = snake(featureNameInput);
  final screenName = snake(screenNameInput);

  // Page naming convention
  // add_expense -> add_expense_page.dart
  final pageFileName = '${screenName}_page.dart';
  final cubitFileName = '${screenName}_cubit.dart';
  final stateFileName = '${screenName}_state.dart';

  final pageClassName = '${pascalFromSnake(screenName)}Page';
  final cubitClassName = '${pascalFromSnake(screenName)}Cubit';
  final stateClassName = '${pascalFromSnake(screenName)}State';

  final projectDir = Directory.current.path;

  // Base feature path
  final featureBase = '$projectDir/lib/features/$featureName';

  // Target folders
  final dataBase = '$featureBase/data';
  final domainBase = '$featureBase/domain';
  final presentationBase = '$featureBase/presentation';

  final cubitDir = '$presentationBase/cubit';
  final pagesDir = '$presentationBase/pages';
  final widgetsDir = '$presentationBase/widgets';

  // Ensure folders exist (create feature structure if missing)
  await ensureDir('$dataBase/datasources');
  await ensureDir('$dataBase/repositories');
  await ensureDir('$domainBase/repositories');
  await ensureDir('$domainBase/usecases');
  await ensureDir(cubitDir);
  await ensureDir(pagesDir);
  await ensureDir(widgetsDir);

  // Ensure index.dart for each layer folder
  final featureIndex = '$featureBase/index.dart';

  final dataIndex = '$dataBase/index.dart';
  final dataDsIndex = '$dataBase/datasources/index.dart';
  final dataRepoIndex = '$dataBase/repositories/index.dart';

  final domainIndex = '$domainBase/index.dart';
  final domainRepoIndex = '$domainBase/repositories/index.dart';
  final domainUsecasesIndex = '$domainBase/usecases/index.dart';

  final presentationIndex = '$presentationBase/index.dart';
  final presentationCubitIndex = '$cubitDir/index.dart';
  final presentationPagesIndex = '$pagesDir/index.dart';
  final presentationWidgetsIndex = '$widgetsDir/index.dart';

  await ensureIndexFile(featureIndex);
  await ensureIndexFile(dataIndex);
  await ensureIndexFile(dataDsIndex);
  await ensureIndexFile(dataRepoIndex);

  await ensureIndexFile(domainIndex);
  await ensureIndexFile(domainRepoIndex);
  await ensureIndexFile(domainUsecasesIndex);

  await ensureIndexFile(presentationIndex);
  await ensureIndexFile(presentationCubitIndex);
  await ensureIndexFile(presentationPagesIndex);
  await ensureIndexFile(presentationWidgetsIndex);

  // -------- Create Cubit + State + Page --------

  final stateContent =
      '''
import 'package:equatable/equatable.dart';

class $stateClassName extends Equatable {
  final bool isLoading;

  const $stateClassName({required this.isLoading});

  factory $stateClassName.initial() => const $stateClassName(isLoading: false);

  $stateClassName copyWith({bool? isLoading}) {
    return $stateClassName(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isLoading];
}
''';

  final cubitContent =
      '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '$stateFileName';

class $cubitClassName extends Cubit<$stateClassName> {
  $cubitClassName() : super($stateClassName.initial());

  // Call this in the page init if you need initial loading logic.
  Future<void> init() async {
    // TODO: Implement init logic.
  }
}
''';

  final pageContent =
      '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/$cubitFileName';
import '../cubit/$stateFileName';

class $pageClassName extends StatelessWidget {
  const $pageClassName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => $cubitClassName()..init(),
      child: BlocBuilder<$cubitClassName, $stateClassName>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('$pageClassName'),
            ),
            body: Center(
              child: Text(
                state.isLoading ? 'Loading...' : '$pageClassName',
              ),
            ),
          );
        },
      ),
    );
  }
}
''';

  // Write files
  final statePath = '$cubitDir/$stateFileName';
  final cubitPath = '$cubitDir/$cubitFileName';
  final pagePath = '$pagesDir/$pageFileName';

  await File(statePath).writeAsString(stateContent);
  await File(cubitPath).writeAsString(cubitContent);
  await File(pagePath).writeAsString(pageContent);

  // -------- Update index.dart exports --------

  // Presentation folder exports
  await upsertExport(
    indexPath: presentationCubitIndex,
    exportLine: "export '$stateFileName';",
  );
  await upsertExport(
    indexPath: presentationCubitIndex,
    exportLine: "export '$cubitFileName';",
  );

  await upsertExport(
    indexPath: presentationPagesIndex,
    exportLine: "export '$pageFileName';",
  );

  // presentation/index.dart exports
  await upsertExport(
    indexPath: presentationIndex,
    exportLine: "export 'cubit/index.dart';",
  );
  await upsertExport(
    indexPath: presentationIndex,
    exportLine: "export 'pages/index.dart';",
  );
  await upsertExport(
    indexPath: presentationIndex,
    exportLine: "export 'widgets/index.dart';",
  );

  // data/index.dart exports
  await upsertExport(
    indexPath: dataIndex,
    exportLine: "export 'datasources/index.dart';",
  );
  await upsertExport(
    indexPath: dataIndex,
    exportLine: "export 'repositories/index.dart';",
  );

  // domain/index.dart exports
  await upsertExport(
    indexPath: domainIndex,
    exportLine: "export 'repositories/index.dart';",
  );
  await upsertExport(
    indexPath: domainIndex,
    exportLine: "export 'usecases/index.dart';",
  );

  // feature/index.dart exports
  await upsertExport(
    indexPath: featureIndex,
    exportLine: "export 'data/index.dart';",
  );
  await upsertExport(
    indexPath: featureIndex,
    exportLine: "export 'domain/index.dart';",
  );
  await upsertExport(
    indexPath: featureIndex,
    exportLine: "export 'presentation/index.dart';",
  );

  print('✅ Screen generated successfully!');
  print('Feature: $featureName');
  print('Page: $pagePath');
  print('Cubit: $cubitPath');
  print('State: $statePath');
}
