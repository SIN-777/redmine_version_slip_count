require 'redmine'

Redmine::Plugin.register :redmine_version_slip_count do
  name 'Redmine Version Slip Count plugin'
  author 'SIN-777'
  description "Count up when issue's fixed_version is slipped."
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  settings :default => {
    :lv1_start => 2,
    :lv2_start => 4,
    :lv3_start => 6,
    :lv1_class => 'version-slip-lv-1',
    :lv2_class => 'version-slip-lv-2',
    :lv3_class => 'version-slip-lv-3',
  }, :partial => 'settings/version_slip_count_settings'
end

require File.dirname(__FILE__) + '/lib/version_slip_count_issue_patch.rb'
require File.dirname(__FILE__) + '/lib/version_slip_count_journal_patch.rb'
Issue.send(:include, VersionSlipCountIssuePatch)
Journal.send(:include, VersionSlipCountJournalPatch)

