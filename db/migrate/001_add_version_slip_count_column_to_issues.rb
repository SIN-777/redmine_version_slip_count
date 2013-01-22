class AddVersionSlipCountColumnToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :version_slip_count, :integer, :null => false, :default => 0
    Issue.find(:all).each do |issue|
      count = issue.journals.map(&:details).select{|detail| detail.any?{|d| d.prop_key == 'fixed_version_id'}}.length
      issue.update_attributes :version_slip_count => count
    end
  end

  def self.down
    remove_column :issues, :version_slip_count
  end
end
