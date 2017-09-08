// Copyright 2017 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:apps.modules.googleapis.services.errors/error.fidl.dart'
    as error_fidl;
import 'package:apps.modules.googleapis.services.gmail/labels.fidl.dart'
    as labels_fidl;
import 'package:googleapis/gmail/v1.dart';
import 'package:lib.logging/logging.dart';

import '../gmail_rest_api.dart';

/// Callback with err, label.
typedef void LabelCallback(error_fidl.Error err, labels_fidl.Label label);

/// Callback with err, labels.
typedef void LabelsCallback(
    error_fidl.Error err, List<labels_fidl.Label> labels);

/// Callback with err.
typedef void Errback(error_fidl.Error err);

/// Implementation for the [Labels] service.
class GmailLabelsImpl extends labels_fidl.Labels {
  /// Access to the GMail REST API.
  // final gmail.GmailApi api = ;
  // _gmail = new gmail.GmailApi(this._client);

  @override
  void create(labels_fidl.Label label, LabelCallback callback) {}

  @override
  void delete(String id, Errback callback) {}

  // 2.
  @override
  void get(String id, LabelCallback callback) {}

  // 1.
  @override
  Future<Null> list(LabelsCallback callback) async {
    // hit LRU
    // hit FS
    // hit Remote

    GmailApi gmail = await API.fromTokenProvider();
    ListLabelsResponse response;

    try {
      response = await gmail.users.labels.list('me');
      // ApiRequestError
    } on DetailedApiRequestError catch (err) {
      error_fidl.Error error = new error_fidl.Error()
        ..code = err.status
        ..message = err.message
        ..errors = err.errors.map((ApiRequestErrorDetail details) {
          error_fidl.ErrorCause cause = new error_fidl.ErrorCause()
            ..domain = details.domain
            ..reason = details.reason
            ..message = details.message
            ..extendedHelp = details.extendedHelp;
          return cause;
        });

      return callback(error, null);
    } on ApiRequestError catch (err) {
      error_fidl.Error error = new error_fidl.Error()..message = err.message;
      return callback(error, null);
    } catch (err) {
      error_fidl.Error error = new error_fidl.Error()
        ..message = 'unkown error: ${err.message}';
      callback(error, null);
      rethrow;
    }

    log.info('response: $response');
  }

  @override
  void patch(labels_fidl.Label label, LabelCallback callback) {}

  @override
  void update(labels_fidl.Label label, LabelCallback callback) {}
}
