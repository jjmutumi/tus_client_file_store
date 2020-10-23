import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tus_client_file_store/tus_client_file_store.dart';

void main() {
  group('url_store:TusFileStore', () {
    final fingerprint = "test";
    final url = "https://example.com/files/pic.jpg?token=987298374";
    final uri = Uri.parse(url);
    final directory = Directory("test-dir");

    test("set", () async {
      TusFileStore store = TusFileStore(directory);
      await store.set(fingerprint, uri);
      final foundUrl = await store.get(fingerprint);
      expect(foundUrl, uri);
    });

    test("get.empty", () async {
      TusFileStore store = TusFileStore(directory);
      final foundUrl = await store.get(fingerprint);
      expect(foundUrl, isNull);
    });

    test("remove", () async {
      TusFileStore store = TusFileStore(directory);
      await store.set(fingerprint, uri);
      await store.remove(fingerprint);
      final foundUrl = await store.get(fingerprint);
      expect(foundUrl, isNull);
    });

    test("remove.empty", () async {
      TusFileStore store = TusFileStore(directory);
      var foundUrl = await store.get(fingerprint);
      expect(foundUrl, isNull);
      await store.remove(fingerprint);
      foundUrl = await store.get(fingerprint);
      expect(foundUrl, isNull);
    });

    tearDown(() async {
      await directory.delete(recursive: true);
    });
  });
}
