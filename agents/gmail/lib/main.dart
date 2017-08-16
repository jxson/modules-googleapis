// Copyright 2017 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:application.lib.app.dart/app.dart';
import 'package:apps.maxwell.services.suggestion/proposal_publisher.fidl.dart';
import 'package:apps.maxwell.services.user/intelligence_services.fidl.dart';
import 'package:apps.modular.services.agent/agent.fidl.dart';
import 'package:apps.modular.services.agent/agent_context.fidl.dart';
import 'package:apps.modular.services.auth/token_provider.fidl.dart';
import 'package:apps.modular.services.component/component_context.fidl.dart';
import 'package:apps.modules.email.services.email/email_content_provider.fidl.dart'
    as ecp;
import 'package:lib.fidl.dart/bindings.dart';
import 'package:lib.logging/logging.dart';
import 'package:lib.modular/modular.dart';
import 'package:meta/meta.dart';

/// The instance of this agent.
GmailAgent agent;

/// An implementation of the [Agent] interface.
class GmailAgent extends AgentImpl {
  /// Creates a new instance of [EmailContentProviderAgent].
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
  setupLogger(
    name: 'googleapis/gmail',
    level: Level.INFO,
  );

  _agent = new GmailAgent(
    applicationContext: new ApplicationContext.fromStartupInfo(),
  );
  _agent.advertise();
}
