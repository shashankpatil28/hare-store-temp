// fix_languages.dart
import 'dart:convert';
import 'dart:io';

void main() async {
  // Store the strings map in memory
  final Map<String, String> strings = {
    "appName": "Hare Store",
    "liveOrders": "Live Orders",
    "permissionText1": "Allow {appName} to display over Other apps",
    "permissionText2": "Allow {appName} to display over Other apps in Order to receive orders when you're online.",
    "permissionText3": "Tap Allow and slide the toggle on the Settings screen on to on",
    "permissionText4": "Set the Quick access icon to on to see this icon over other apps",
    // ... (your entire strings map here)
  };

  print('Starting language string replacement...');
  
  // Create backup directory with timestamp
  final backupDir = 'backup_${DateTime.now().millisecondsSinceEpoch}';
  await Directory(backupDir).create();
  
  // Process all .dart files in lib directory
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    print('Error: lib directory not found!');
    return;
  }

  int filesModified = 0;
  int replacementsCount = 0;

  // Walk through all .dart files
  await for (final entity in libDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      // Create backup
      final backupPath = '$backupDir/${entity.path.replaceAll('/', '_')}';
      await entity.copy(backupPath);

      String content = await entity.readAsString();
      bool fileModified = false;
      
      // Find all instances of languages.<something>
      final regex = RegExp(r'languages\.([a-zA-Z0-9_]+)');
      final matches = regex.allMatches(content);
      
      for (final match in matches) {
        final fullMatch = match.group(0)!; // languages.something
        final key = match.group(1)!; // just the something part
        
        if (strings.containsKey(key)) {
          String replacement = strings[key]!;
          // Properly escape the replacement string for Dart
          replacement = replacement
              .replaceAll(r'\', r'\\')
              .replaceAll("'", r"\'")
              .replaceAll(r'$', r'\$')
              .replaceAll('\n', r'\n');
          
          content = content.replaceAll(fullMatch, "'$replacement'");
          fileModified = true;
          replacementsCount++;
        }
      }
      
      if (fileModified) {
        await entity.writeAsString(content);
        filesModified++;
        print('Modified: ${entity.path}');
      }
    }
  }

  print('\nSummary:');
  print('Files modified: $filesModified');
  print('Total replacements made: $replacementsCount');
  print('Backups saved in: $backupDir');
  print('\nTo restore from backup, use:');
  print('cp -r $backupDir/* lib/');
}