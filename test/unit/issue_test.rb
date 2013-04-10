# coding: utf-8

require File.dirname(__FILE__) + '/../test_helper'

class IssueTest < ActiveSupport::TestCase
  fixtures :projects, :users, :members, :member_roles, :roles,
           :trackers, :projects_trackers,
           :enabled_modules,
           :versions,
           :issue_statuses, :issue_categories, :issue_relations, :workflows,
           :enumerations,
           :issues,
           :custom_fields, :custom_fields_projects, :custom_fields_trackers, :custom_values,
           :time_entries,
           :journals, :journal_details

  def setup
    @settings = Setting.plugin_redmine_version_slip_count
  end

  test '自身のjournal_detailsから現在のバージョン変更回数を取得できる' do
    issue = Issue.first
    assert_equal 0, issue.get_version_slip_count_by_journals

    issue = Issue.find(6)
    assert_equal 1, issue.get_version_slip_count_by_journals
  end

  test 'バージョンを変更してsaveするとversion_slip_countが更新される' do
    issue = Issue.first
    issue.init_journal(User.first)
    issue.fixed_version = issue.assignable_versions.first
    assert_difference 'issue.version_slip_count', 1 do
      issue.save!
      issue.reload
    end
  end


  test 'issue.css_classesはバージョン変更回数が設定"lv1_start"未満のIssueは設定"lv0_class"のclass名を含む' do
    @settings[:lv1_start].times do |i|
      issue = Issue.first

      if i < @settings[:lv1_start]
        assert_equal i, issue.version_slip_count
        assert issue.css_classes.include?(@settings[:lv0_class])
      end

      issue.init_journal(User.first)
      issue.fixed_version = issue.assignable_versions[i % 2]
      issue.save!
    end
  end

  test 'issue.css_classesはバージョン変更回数が設定"lv1_start"以上-設定"lv2_start"未満の場合、設定"lv1_class"のclass名を含む' do
    @settings[:lv2_start].times do |i|
      issue = Issue.first

      if (@settings[:lv1_start]...@settings[:lv2_start]).include?(i)
        assert_equal i, issue.version_slip_count
        assert issue.css_classes.include?(@settings[:lv1_class])
      end

      issue.init_journal(User.first)
      issue.fixed_version = issue.assignable_versions[i % 2]
      issue.save!
    end
  end

  test 'issue.css_classesはバージョン変更回数が設定"lv2_start"以上-設定"lv3_start"未満の場合、設定"lv2_class"のclass名を含む' do
    @settings[:lv3_start].times do |i|
      issue = Issue.first

      if (@settings[:lv2_start]...@settings[:lv3_start]).include?(i)
        assert_equal i, issue.version_slip_count
        assert issue.css_classes.include?(@settings[:lv2_class])
      end

      issue.init_journal(User.first)
      issue.fixed_version = issue.assignable_versions[i % 2]
      issue.save!
    end
  end

  test 'issue.css_classesはバージョン変更回数が設定"lv3_start"より大きい場合、設定"lv3_class"のclass名を含む' do
    (@settings[:lv3_start]+1).times do |i|
      issue = Issue.first

      if @settings[:lv3_start] < i
        assert_equal i, issue.version_slip_count
        assert issue.css_classes.include?(@settings[:lv2_class])
      end

      issue.init_journal(User.first)
      issue.fixed_version = issue.assignable_versions[i % 2]
      issue.save!
    end
  end


end





