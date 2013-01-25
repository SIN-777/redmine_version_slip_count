module VersionSlipCountJournalPatch
  def self.included(klass)
    klass.send(:include, InstanceMethods)
    klass.class_eval do
      after_save :update_version_slip_count
    end
  end

  module InstanceMethods
    def update_version_slip_count
      count = self.issue.get_version_slip_count_by_journals
      self.issue.version_slip_count = count
      self.issue.save
    end
  end
end


