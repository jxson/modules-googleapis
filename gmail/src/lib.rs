#![feature(asm)]
#![allow(unused_variables)]

extern crate magenta;
extern crate magenta_sys;
extern crate mxruntime;
extern crate fidl;
extern crate application_services_service_provider;
extern crate application_services;
extern crate apps_modular_services_agent;

pub mod fuchsia;

use fuchsia::ApplicationContext;
use apps_modular_services_agent::{Agent, AgentContext_Client};
use fidl::{InterfacePtr};
use std::string::String;
use application_services_service_provider::ServiceProvider_Server;

pub struct GmailAgent {
    // pub application_context: ApplicationContext,
}

impl GmailAgent {
    pub fn new(application_context: &mut ApplicationContext) -> GmailAgent {
        GmailAgent {
            // application_context: application_context
        }
    }
}

impl Agent for GmailAgent {
    fn  initialize(&mut self, agent_context: InterfacePtr<AgentContext_Client>) -> fidl::Future<(), fidl::Error> {

        print!("initialize called");

        fidl::Future::Ok(())
    }

    fn connect(&mut self, url: String, services: ServiceProvider_Server) {
        print!("connect called");
    }

    fn run_task(&mut self, name: String) -> fidl::Future<(), fidl::Error> {
        print!("run_task called");

        fidl::Future::Ok(())
    }

    fn stop(&mut self) -> fidl::Future<(), fidl::Error> {
        print!("stop called");

        fidl::Future::Ok(())
    }
}
