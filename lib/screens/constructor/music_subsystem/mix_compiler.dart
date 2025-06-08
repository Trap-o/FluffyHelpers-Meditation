import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

Future<double> getAudioDuration(String filePath) async {
  final session = await FFprobeKit.getMediaInformation(filePath);
  final info = session.getMediaInformation();
  if (info == null) {
    throw Exception('File info error: $filePath');
  }
  return double.parse(info.getDuration() ?? '0');
}

Future<void> createMixedTrack(List<int?> activeIndices, Duration length) async {

  final dir = await getApplicationDocumentsDirectory();
  final outputPath = '${dir.path}/output_mix.mp3';

  final validIndices = activeIndices.whereType<int>().toList();
  final inputs = <String>[];
  final filters = <String>[];

  const sampleRate = 44100;

  for (int i = 0; i < validIndices.length; i++) {
    final index = validIndices[i];
    final trackPath = 'assets/music/constructor_music_$index.mp3';
    final inputAlias = 'a$i';

    final tempFile = File('${dir.path}/track_$i.mp3');
    final data = await rootBundle.load(trackPath);
    await tempFile.writeAsBytes(data.buffer.asUint8List());

    final duration = await getAudioDuration(tempFile.path);

    final loopCount = (length.inSeconds / duration).ceil();
    final size = (duration * sampleRate).toInt();

    inputs.add('-i "${tempFile.path}"');

    filters.add(
        '[$i]aloop=loop=${loopCount - 1}:size=$size:start=0,'
            'atrim=duration=${length.inSeconds},'
            'volume=1.0,'
            'asetpts=N/SR/TB[$inputAlias]'
    );
  }

  final joinedInputs = List.generate(validIndices.length, (i) => '[a$i]').join();
  final filterComplex = '''
    ${filters.join(';')};
    $joinedInputs
    amix=inputs=${validIndices.length}:duration=longest,
    atrim=duration=${length.inSeconds}
    [out]
  ''';

  final command = '${inputs.join(' ')} -filter_complex "$filterComplex" -map "[out]" -y "$outputPath"';

  final session = await FFmpegKit.execute(command);
  final returnCode = await session.getReturnCode();

  if (ReturnCode.isSuccess(returnCode)) {
    print('FFmpeg команда виконана успішно');
  } else {
    print('Помилка FFmpeg, код: $returnCode');
    final failStackTrace = await session.getFailStackTrace();
    if (failStackTrace != null) {
      print('StackTrace: $failStackTrace');
    }
  }
}


