namespace :redmine do
  namespace :additionals do
    desc <<-DESCRIPTION
    Drop plugin settings.

    Example:
      bundle exec rake redmine:additionals:drop_settings RAILS_ENV=production plugin="redmine_plugin_example"
    DESCRIPTION
    task drop_settings: :environment do
      plugin = ENV['plugin']

      if plugin.blank?
        puts 'Parameter plugin is required.'
        exit 2
      end

      Setting.where(name: "plugin_#{plugin}".to_sym).destroy_all
      Setting.clear_cache
      puts "Setting for plugin #{plugin} has been dropped."
    end

    desc <<-DESCRIPTION
    Set settings.

    Example:
      bundle exec rake redmine:additionals:set_setting RAILS_ENV=production name="additionals" setting="external_urls" value="2"
    DESCRIPTION
    task setting_set: :environment do
      name = ENV['name'] ||= 'redmine'
      setting = ENV['setting']
      value = ENV['value']

      if name.blank? || setting.blank? || value.blank?
        puts 'Parameters setting and value are required.'
        exit 2
      end

      if name == 'redmine'
        Setting[setting.to_sym] = value
      else
        plugin_name = "plugin_#{name}".to_sym
        plugin_settings = Setting[plugin_name]
        plugin_settings[setting] = value
        Setting[plugin_name] = plugin_settings
      end
    end

    desc <<-DESCRIPTION
    Get settings.

    Example for plugin setting:
      bundle exec rake redmine:additionals:get_setting RAILS_ENV=production name="additionals" setting="external_urls"
    Example for redmine setting:
      bundle exec rake redmine:additionals:get_setting RAILS_ENV=production name="redmine" setting="app_title"
    Example for redmine setting:
      bundle exec rake redmine:additionals:get_setting RAILS_ENV=production setting="app_title"
    DESCRIPTION
    task setting_get: :environment do
      name = ENV['name'] ||= 'redmine'
      setting = ENV['setting']

      if setting.blank?
        puts 'Parameters setting is required'
        exit 2
      end

      if name == 'redmine'
        puts Setting.send(setting)
      else
        plugin_name = "plugin_#{name}".to_sym
        plugin_settings = Setting[plugin_name]
        puts plugin_settings[setting]
      end
    end
  end
end