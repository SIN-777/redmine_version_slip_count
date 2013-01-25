require File.dirname(__FILE__) + '/../test_helper'

class IssueTest < ActiveSupport::TestCase
  # fixtures :issues, :versions, :projects, :journals, :journal_details

  fixtures :projects, :users, :members, :member_roles, :roles,
           :trackers, :projects_trackers,
           :enabled_modules,
           :versions,
           :issue_statuses, :issue_categories, :issue_relations, :workflows,
           :enumerations,
           :issues,
           :custom_fields, :custom_fields_projects, :custom_fields_trackers, :custom_values,
           :time_entries

  test 'バージョンを変更してsaveするとversion_slip_countが更新される' do
    issue = Issue.first
    issue.init_journal(User.first)
    issue.fixed_version = issue.assignable_versions.first
    assert_difference 'issue.version_slip_count', 1 do
      issue.save!
      issue.reload
    end
  end

  test 'バージョン変更回数によってIssueは所定の "version-slip-lv-*" class を持つ' do
    7.times do |i|
      issue = Issue.first

      assert_equal i, issue.version_slip_count
      case issue.version_slip_count
      when 0..1
        assert_equal false, issue.css_classes.include?('version-slip-lv')
      when 2..3
        assert issue.css_classes.include?('version-slip-lv-1')
      when 4..5
        assert issue.css_classes.include?('version-slip-lv-2')
      else
        assert issue.css_classes.include?('version-slip-lv-3')
      end

      issue.init_journal(User.first)
      issue.fixed_version = issue.assignable_versions[i % 2]
      issue.save!
    end
  end



end





