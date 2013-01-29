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
        s << case version_slip_count
             when 0...Setting.plugin_redmine_version_slip_count[:lv1_start]
               ""
             when Setting.plugin_redmine_version_slip_count[:lv1_start]...Setting.plugin_redmine_version_slip_count[:lv2_start]
               " #{Setting.plugin_redmine_version_slip_count[:lv1_class]}"
             when Setting.plugin_redmine_version_slip_count[:lv2_start]...Setting.plugin_redmine_version_slip_count[:lv3_start]
               " #{Setting.plugin_redmine_version_slip_count[:lv2_class]}"
             else
               " #{Setting.plugin_redmine_version_slip_count[:lv3_class]}"
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

