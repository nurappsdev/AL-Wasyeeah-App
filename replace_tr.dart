import 'dart:convert';
import 'dart:io';

void main() {
  final mappingFile = File('lib/l10n/mapping.json');
  if (!mappingFile.existsSync()) return;

  final mapping =
      json.decode(mappingFile.readAsStringSync()) as Map<String, dynamic>;

  void processDirectory(Directory dir) {
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is File &&
          entity.path.endsWith('.dart') &&
          !entity.path.contains('app_localizations')) {
        String content = entity.readAsStringSync();
        bool changed = false;

        // Pattern handles "string".tr or 'string'.tr
        final pattern = RegExp(r'''(['"])(.*?)\1\.tr''');

        content = content.replaceAllMapped(pattern, (match) {
          final str = match.group(2);
          final key = mapping[str];
          if (key != null) {
            changed = true;
            return 'AppLocalizations.of(context)!.$key';
          }
          return match.group(0)!;
        });

        // Also handle SomeClass("something").tr -> wait, .tr is a getter, usually called on literals.
        // We covered literals.

        if (changed) {
          // Add import if not present
          if (!content.contains('app_localizations.dart')) {
            final relativeDepth =
                RegExp(r'\/|\\').allMatches(entity.path).length - 1;
            String importPath =
                "import 'package:al_wasyeah/l10n/app_localizations.dart';\n";

            // Put import after the last import
            final lastImportIdx =
                content.lastIndexOf(RegExp(r'^import .*;', multiLine: true));
            if (lastImportIdx != -1) {
              final endOfImport = content.indexOf('\n', lastImportIdx) + 1;
              content = content.substring(0, endOfImport) +
                  importPath +
                  content.substring(endOfImport);
            } else {
              content = importPath + content;
            }
          }
          entity.writeAsStringSync(content);
          print('Updated ${entity.path}');
        }
      }
    }
  }

  processDirectory(Directory('lib'));
}
