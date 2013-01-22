module VersionSlipCounterIssuePatch
  def self.included(klass)
    klass.send(:include, InstanceMethods)
    klass.class_eval do
      alias_method_chain :css_classes, :version_slip_count
    end
  end

  module InstanceMethods
    def css_classes_with_version_slip_count
      s = css_classes_without_version_slip_count
      # unless status.is_closed?
      #   s << case version_slip_count
      #        when 0..2
      #          ' version-slip-lv-1'
      #        when 3..4
      #          ' version-slip-lv-2'
      #        when 5..6
      #          ' version-slip-lv-3'
      #        else
      #          ' version-slip-lv-4'
      #        end
      # end
      s
    end
  end
end

