// Copyright 2017 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:application.lib.app.dart/app.dart';
import 'package:apps.modular.services.agent/agent.fidl.dart';
import 'package:apps.modular.services.agent/agent_context.fidl.dart';
import 'package:apps.modular.services.auth/token_provider.fidl.dart';
import 'package:apps.modular.services.component/component_context.fidl.dart';
import 'package:lib.logging/logging.dart';
import 'package:lib.modular/modular.dart';
import 'package:meta/meta.dart';

/// GmailAgent instance.
GmailAgent agent;

/// The GMail specific implementation of the [Agent] interface.
class GmailAgent extends AgentImpl {
  /// Creates a new instance of [GmailAgent].
  GmailAgent({
    @required ApplicationContext applicationContext,
  })
      : super(applicationContext: applicationContext);

  @override
  Future<Null> onReady(
    ApplicationContext applicationContext,
    AgentContext agentContext,
    ComponentContext componentContext,
    TokenProvider tokenProvider,
    ServiceProviderImpl outgoingServices,
  ) async {
    log.fine('onReady fired');
  }

  @override
  Future<Null> onStop() async {
    log.fine('onStop fired');
  }

  @override
  Future<Null> onRunTask(String taskId) async {
    log.fine('onRunTask("$taskId")');
  }
}

/// Main entry point.
Future<Null> main(List<String> args) async {
  setupLogger(name: 'googleapis/gmail');

  agent = new GmailAgent(
    applicationContext: new ApplicationContext.fromStartupInfo(),
  );
  agent.advertise();
}
