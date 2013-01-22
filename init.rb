require 'redmine'

Redmine::Plugin.register :redmine_version_slip_counter do
  name 'Redmine Version Slip Counter plugin'
  author 'SIN-777'
  description "Count up when issue's fixed_version is slipped."
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

require File.dirname(__FILE__) + '/lib/version_slip_counter_patch.rb'
Issue.send(:include, VersionSlipCounterPatch)

