// Copyright 2017 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:apps.modular.services.auth/token_provider.fidl.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:lib.logging/logging.dart';

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestErrorDetail;

/// Helper to access and contain an EmailAPI singleton.
class API {
  /// A proxy to the [TokenProvider] service.
  static TokenProviderProxy tokenProvider;

  /// Oauth scopes.
  static final List<String> scopes = <String>[
    'openid',
    'email',
    'https://www.googleapis.com/auth/gmail.modify',
  ];

  /// Get an access token from the [tokenProvider] using the idiomatic async
  /// Dart [Future].
  static Future<String> getAccessToken() {
    Completer<String> completer = new Completer<String>();
    tokenProvider.getAccessToken((String token, AuthErr authErr) {
      if (token != null)
        completer.complete(token);
      else {
        StateError err = new StateError(
            'status: ${authErr.status}, message: ${authErr.message}');
        log.severe('getAccessToken failed: $authErr');
        completer.completeError(err);
      }
    });

    return completer.future;
  }

  /// Async getter/loader.
  static Future<GmailApi> fromTokenProvider() async {
    String token = await getAccessToken();
    DateTime expiry = new DateTime.now().add(new Duration(minutes: 50)).toUtc();

    AccessToken accessToken = new AccessToken('Bearer', token, expiry);
    AccessCredentials credentials =
        new AccessCredentials(accessToken, null, scopes);
    Client baseClient = new Client();
    AuthClient client = authenticatedClient(baseClient, credentials);

    return new GmailApi(client);
  }
}
