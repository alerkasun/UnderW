#workaround for https://github.com/railsconfig/rails_config/issues/92

Spring.watch "config/settings.yml"
Spring.watch "config/settings.local.yml"
Dir.glob('config/settings*').each{ |settings| Spring.watch settings }
