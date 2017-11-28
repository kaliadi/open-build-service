#!/usr/bin/env ruby.ruby2.4

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))
require 'delayed/command'
#require_relative '../app/models/event'
#require_relative '../app/models/event/package'
#require_relative '../app/models/event/project'
Delayed::Command.new(ARGV).daemonize
