import 'dart:io';

void main() {
  final dir = Directory('lib/view/screen');
  if (!dir.existsSync()) return;

  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((e) => e.path.endsWith('.dart'));

  final pattern1 = RegExp(r'"([^"]+)"\.tr');
  final pattern2 = RegExp(r"'([^']+)'\.tr");
  final pattern3 = RegExp(r'AppString\.([a-zA-Z0-9_]+)\.tr');
  final pattern4 = RegExp(r'AppString\.([a-zA-Z0-9_]+)(?!\.tr)');

  String makeIdentifier(String s) {
    s = s.trim();
    s = s.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    s = s.replaceAll(RegExp(r'_+'), '_');
    s = s.replaceAll(RegExp(r'^_|_$'), '');
    s = s.toLowerCase();
    if (s.isEmpty) return 'empty_string';
    if (RegExp(r'^[0-9]').hasMatch(s)) s = 'num_$s';
    return s;
  }

  String camelToSnake(String name) {
    var s1 = name.replaceAllMapped(
        RegExp(r'(.)([A-Z][a-z]+)'), (m) => '${m[1]}_${m[2]}');
    return s1
        .replaceAllMapped(
            RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}')
        .toLowerCase();
  }

  for (var file in files) {
    final content = file.readAsStringSync();
    var newContent = content;

    newContent = newContent.replaceAllMapped(pattern1, (m) {
      final ident = makeIdentifier(m[1]!);
      return 'AppLocalizations.of(context)!.\$ident';
    });

    newContent = newContent.replaceAllMapped(pattern2, (m) {
      final ident = makeIdentifier(m[1]!);
      return 'AppLocalizations.of(context)!.\$ident';
    });

    newContent = newContent.replaceAllMapped(pattern3, (m) {
      final prop = m[1]!;
      final ident = camelToSnake(prop);
      return 'AppLocalizations.of(context)!.\$ident';
    });

    newContent = newContent.replaceAllMapped(pattern4, (m) {
      final prop = m[1]!;
      final ident = camelToSnake(prop);
      return 'AppLocalizations.of(context)!.\$ident';
    });

    if (content != newContent) {
      if (!newContent.contains('app_localizations.dart')) {
        final match =
            RegExp(r'^import .*?;', multiLine: true).firstMatch(newContent);
        if (match != null) {
          newContent = newContent.replaceRange(match.start, match.end,
              "\${match.group(0)}\\nimport 'package:al_wasyeah/l10n/app_localizations.dart';");
        }
      }
      // Replace \$ident back to actual interpolated because of backslash escaping in Dart
      newContent = newContent.replaceAll(
          r'.$ident', ''); // wait the code above used \$ident
      // Let's fix the above replacements:
    }
  }
}
