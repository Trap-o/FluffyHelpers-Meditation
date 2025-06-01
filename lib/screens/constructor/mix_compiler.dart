import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

Future<void> createMixedTrack(List<int?> activeIndices, Duration length) async {
  print('✅ Виклик createMixedTrack');

  final dir = await getApplicationDocumentsDirectory();
  final outputPath = '${dir.path}/output_mix.mp3';

  final loopCount = (length.inSeconds / 30).ceil(); // приблизно, налаштовується далі
  final inputs = <String>[];
  final filters = <String>[];

  for (int i = 0; i < activeIndices.length; i++) {
    if(activeIndices[i] == null){
      break;
    }
    final index = activeIndices[i];
    final trackPath = 'assets/music/constructor_music_$index.mp3';
    final inputAlias = 'a$i';

    // Зберігаємо трек у тимчасовій директорії
    final tempFile = File('${dir.path}/track_$i.mp3');
    final data = await rootBundle.load(trackPath);
    await tempFile.writeAsBytes(data.buffer.asUint8List());

    for (int i = 0; i < activeIndices.length; i++) {
      final tempFile = File('${dir.path}/track_$i.mp3');
      print('Track $i exists: ${await tempFile.exists()}');
    }

    // Додаємо input до команди FFmpeg
    inputs.add('-i "${tempFile.path}"');

    // Додаємо фільтр повтору чи обрізання
    filters.add('[$i]aloop=loop=${loopCount - 1}:size=0:start=0,atrim=duration=${length.inSeconds}[$inputAlias]');
  }

  final filterComplex = '${filters.join(';')};${activeIndices
          .asMap()
          .entries
          .map((e) => '[a${e.key}]')
          .join()}amix=inputs=${activeIndices.length}:duration=shortest[out]';

  final command = '${inputs.join(' ')} -filter_complex "$filterComplex" -map "[out]" -y "$outputPath"';

  print('🧪 FFmpeg команда:\n$command');

  await FFmpegKit.execute(command);

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