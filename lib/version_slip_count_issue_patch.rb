module VersionSlipCountIssuePatch
  def self.included(klass)
    klass.send(:include, InstanceMethods)
    klass.class_eval do
      alias_method_chain :css_classes, :version_slip_count
    end
  end

  module InstanceMethods
    def css_classes_with_version_slip_count
      s = css_classes_without_version_slip_count
      unless status.is_closed?
        settings = Setting.plugin_redmine_version_slip_count
        s << case version_slip_count
             when 0...settings[:lv1_start].to_i
               " #{settings[:lv0_class]}"
             when settings[:lv1_start].to_i...settings[:lv2_start].to_i
               " #{settings[:lv1_class]}"
             when settings[:lv2_start].to_i...settings[:lv3_start].to_i
               " #{settings[:lv2_class]}"
             else
               " #{settings[:lv3_class]}"
             end

      end
      s
    end

    def get_version_slip_count_by_journals
      version_slips = journals.map(&:details).select do |detail|
        detail.any? do |d|
          d.prop_key == 'fixed_version_id'
        end
      end
      version_slips.length
    end
  end
end

