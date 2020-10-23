import 'dart:io';

import "package:path/path.dart" as p;
import 'package:tus_client/tus_client.dart';

/// This class is used to lookup a [fingerprint] with the
/// corresponding [file] entries in different files on disk.
///
/// This functionality is used to allow resuming uploads.
///
/// This store **will** keep the values after your application crashes or
/// restarts.
class TusFileStore implements TusStore {
  final Directory directory;

  TusFileStore(this.directory);

  @override
  Future<void> set(String fingerprint, Uri url) async {
    final file = await _getFile(fingerprint);
    await file.writeAsString(url.toString());
  }

  @override
  Future<Uri> get(String fingerprint) async {
    final file = await _getFile(fingerprint);
    if (await file.exists()) {
      return Uri.parse(await file.readAsString());
    }
    return null;
  }

  @override
  Future<void> remove(String fingerprint) async {
    final file = await _getFile(fingerprint);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<File> _getFile(fingerprint) async {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    final filePath = p.join(directory.absolute.path, fingerprint);
    return File(filePath);
  }
}
