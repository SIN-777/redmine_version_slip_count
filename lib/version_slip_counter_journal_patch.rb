module VersionSlipCounterJournalPatch
  def self.included(klass)
    klass.send(:include, InstanceMethods)
    klass.class_eval do
      after_save :update_version_slip_count
    end
  end

  module InstanceMethods
    def update_version_slip_count
      count = self.issue.journals.map(&:details).select{|detail| detail.any?{|d| d.prop_key == 'fixed_version_id'}}.length
      self.issue.version_slip_count = count
      self.issue.save
    end
  end
end


