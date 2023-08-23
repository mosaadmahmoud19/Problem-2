
import 'dart:convert';
import 'dart:io';

void processTxtFileAndCreateJson() {
  const txtFilePath = 'assets/image1.txt';
  const jsonFilePath = 'assets/image.json';

  final lines = File(txtFilePath).readAsLinesSync();
  final annotations = <Map<String, dynamic>>[];

  for (final line in lines) {
    final values = line.split(' ').map((v) => double.parse(v)).toList();

    final annotation = {
      'image_rotation': 0,
      'value': {
        'x': values[1] * 100,
        'y': values[2] * 100,
        'width': values[3] * 100,
        'height': values[4] * 100,
        'rotation': 0,
        'rectanglelabels': ['object']
      }
    };

    annotations.add(annotation);
  }

  final jsonData = {
    'annotations': [
      {'result': annotations}
    ],
    'data': {'image': 'assets/image1.txt'}
  };

  final jsonContent = JsonEncoder.withIndent('  ').convert(jsonData);

  File(jsonFilePath).writeAsStringSync(jsonContent);

  print('Conversion completed.');
}

void main() {
  processTxtFileAndCreateJson();
}



