import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

Future<void> createMixedTrack(List<int?> activeIndices, Duration length) async {
  print('✅ Виклик createMixedTrack');
  print('Active indices: $activeIndices');

  final dir = await getApplicationDocumentsDirectory();
  final outputPath = '${dir.path}/output_mix.mp3';

  final validIndices = activeIndices.whereType<int>().toList();
  final loopCount = (length.inSeconds / 30).ceil(); // приблизно, налаштовується далі
  final inputs = <String>[];
  final filters = <String>[];

  for (int i = 0; i < validIndices.length; i++) {
    final index = validIndices[i];
    final trackPath = 'assets/music/constructor_music_$index.mp3';
    final inputAlias = 'a$i';

    final tempFile = File('${dir.path}/track_$i.mp3');
    final data = await rootBundle.load(trackPath);
    await tempFile.writeAsBytes(data.buffer.asUint8List());

    // Перевірка існування
    print('✅ Temp file exists: ${await tempFile.exists()}');
    print('✅ Temp file path: ${tempFile.path}');

    inputs.add('-i "${tempFile.path}"');
    filters.add('[$i]aloop=loop=${loopCount - 1}:size=0:start=0,atrim=duration=${length.inSeconds}[$inputAlias]');
  }

  final filterComplex =
      '${filters.join(';')};${List.generate(validIndices.length, (i) => '[a$i]').join()}amix=inputs=${validIndices.length}:duration=shortest[out]';

  final command = '${inputs.join(' ')} -filter_complex "$filterComplex" -map "[out]" -y "$outputPath"';

  print('🧪 FFmpeg команда:\n$command');

  final session = await FFmpegKit.execute(command);
  final returnCode = await session.getReturnCode();

  if (ReturnCode.isSuccess(returnCode)) {
    print('✅ FFmpeg команда виконана успішно');
  } else {
    print('❌ Помилка FFmpeg, код: $returnCode');
    final failStackTrace = await session.getFailStackTrace();
    if (failStackTrace != null) {
      print('StackTrace: $failStackTrace');
    }
    final output = await session.getOutput();
    print('FFmpeg output: $output');
  }

  print('✅ Шлях: $outputPath');
}