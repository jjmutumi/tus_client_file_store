# Tus client file store

[![Pub Version](https://img.shields.io/pub/v/tus_client_file_store)](https://pub.dev/packages/tus_client_file_store)
[![Build Status](https://travis-ci.org/jjmutumi/tus_client_file_store.svg?branch=master)](https://travis-ci.org/jjmutumi/tus_client_file_store)
[![codecov](https://codecov.io/gh/jjmutumi/tus_client_file_store/branch/master/graph/badge.svg)](https://codecov.io/gh/jjmutumi/tus_client_file_store)

---

This is an extension library for [tus_client](https://github.com/jjmutumi/tus_client) for Flutter.

This library allows saving a file backed persistent state of uploads.
This means the you can resume uploads even if the application is close or the device is restarted.

**Note: This is only supported on Flutter Android, iOS and desktop, i.e. not web**.

- [Tus client file store](#tus-client-file-store)
  - [Installation](#installation)
  - [Usage](#usage)

## Installation

You need to add to your `pubspec.yaml`:

```yaml
dependencies:
  tus_client: ^0.0.5
  tus_client_file_store: ^0.0.1
```

## Usage

```dart
import 'package:path_provider/path_provider.dart';
import 'package:tus_client/tus_client.dart' show TusClient;
import 'package:tus_client_file_store/tus_client_file_store.dart' show TusFileStore;
import 'package:path/path.dart' as p;

// Directory the current uploads will be saved in
final tempDir = (await getTemporaryDirectory()).path;
final tempDirectory = Directory(p.join(tempDir, "tus-uploads"));

// Create a client
final client = TusClient(
    Uri.parse("https://example.com/tus"),
    file,
    store: TusFileStore(tempDirectory),
);

// Start upload
await client.upload();
```
