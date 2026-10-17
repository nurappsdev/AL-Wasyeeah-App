import 'dart:convert';
import 'dart:io';

void main() {
  final enFile = File('assets/language/en.json');
  final bdFile = File('assets/language/bd.json');

  if (!enFile.existsSync() || !bdFile.existsSync()) {
    print('JSON files not found.');
    return;
  }

  final enData = json.decode(enFile.readAsStringSync()) as Map<String, dynamic>;
  final bdData = json.decode(bdFile.readAsStringSync()) as Map<String, dynamic>;

  final arbEn = <String, dynamic>{};
  final arbBn = <String, dynamic>{};
  final mapping = <String, String>{};

  String makeIdentifier(String s) {
    s = s.trim();
    s = s.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    s = s.replaceAll(RegExp(r'_+'), '_');
    s = s.toLowerCase();
    s = s.replaceAll(RegExp(r'^_+|_+$'), '');
    if (s.isEmpty) return 'empty_string';
    if (RegExp(r'^[0-9]').hasMatch(s)) {
      s = 'num_$s';
    }
    return s;
  }

  for (final key in enData.keys) {
    if (key.startsWith('//') || key.trim().isEmpty) continue;

    String ident = makeIdentifier(key);
    String origIdent = ident;
    int counter = 1;
    while (arbEn.containsKey(ident) && arbEn[ident] != enData[key]) {
      ident = '${origIdent}_$counter';
      counter++;
    }

    arbEn[ident] = enData[key];
    arbBn[ident] = bdData[key] ?? enData[key];
    mapping[key] = ident;
  }

  Directory('lib/l10n').createSync(recursive: true);

  File('lib/l10n/intl_en.arb')
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(arbEn));
  File('lib/l10n/intl_bn.arb')
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(arbBn));
  File('lib/l10n/mapping.json')
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(mapping));

  print('Generated ARB files with ${arbEn.length} keys.');
}
