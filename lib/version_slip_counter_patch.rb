module VersionSlipCounterPatch
  def self.included(klass)
    klass.send(:include, InstanceMethods)
    klass.class_eval do
      alias_method_chain :css_classes, :version_slip_count
    end
  end

  module InstanceMethods
    def css_classes_with_version_slip_count
      s = css_classes_without_version_slip_count
      # do something # s << ' version-overdue' if fixed_version.present? && fixed_version.due_date < Date.today && !status.is_closed?
      s
    end
    
    def foo
      puts 'foooooooooooooooooooooo'
    end
  end
end

