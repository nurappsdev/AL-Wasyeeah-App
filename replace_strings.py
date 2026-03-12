import os
import re

directory = 'lib/view/screen'

# Matches "Some string".tr
pattern1 = re.compile(r'"([^"]+)"\.tr')
# Matches 'Some string'.tr
pattern2 = re.compile(r"'([^']+)'\.tr")
# Matches AppString.someProperty.tr
pattern3 = re.compile(r'AppString\.([a-zA-Z0-9_]+)\.tr')
# Matches AppString.someProperty (without .tr)
pattern4 = re.compile(r'AppString\.([a-zA-Z0-9_]+)(?!\.tr)')

def make_identifier(s):
    s = s.strip()
    s = re.sub(r'[^a-zA-Z0-9]', '_', s)
    s = re.sub(r'_+', '_', s)
    s = s.strip('_')
    s = s.lower()
    if not s:
        return 'empty_string'
    if s[0].isdigit():
        s = 'num_' + s
    return s

def camel_to_snake(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original = content
    
    def repl1(m):
        raw_str = m.group(1)
        ident = make_identifier(raw_str)
        return f'AppLocalizations.of(context)!.{ident}'
        
    content = pattern1.sub(repl1, content)
    content = pattern2.sub(repl1, content)
    
    def repl3(m):
        prop = m.group(1)
        # Using camel_to_snake logic for AppString variables to match AppLocalizations fields
        ident = camel_to_snake(prop)
        return f'AppLocalizations.of(context)!.{ident}'
        
    content = pattern3.sub(repl3, content)
    content = pattern4.sub(repl3, content)

    if original != content:
        # Check if AppLocalizations import is needed
        if 'app_localizations.dart' not in content:
            idx = content.find('import ')
            if idx != -1:
                content = content[:idx] + "import 'package:al_wasyeah/l10n/app_localizations.dart';\n" + content[idx:]
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f'Updated {filepath}')

for root, _, files in os.walk(directory):
    for f in files:
        if f.endswith('.dart'):
            process_file(os.path.join(root, f))
