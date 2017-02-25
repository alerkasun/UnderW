Rails.application.configure do
  Settings.reload!
  hostname = Settings.host_config.base_url
  if Settings.host_config.ssl_port && Settings.host_config.ssl_port.to_i != 443
    hostname = "#{hostname}:#{Settings.host_config.ssl_port}"
  end
  config.action_mailer.default_url_options = { host: hostname, protocol: 'https' }

end