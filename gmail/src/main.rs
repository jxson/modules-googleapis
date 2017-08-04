#![allow(unused_variables)]

extern crate gmail;

use gmail::fuchsia::{ApplicationContext, install_panic_backtrace_hook};

fn main() {
    install_panic_backtrace_hook();

    let mut ctx = ApplicationContext::new();
    let agent = gmail::GmailAgent::new(&mut ctx);
    // agent.advertise();
}
