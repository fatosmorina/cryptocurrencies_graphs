CONFIG_PATH="#{Rails.root}/config/api_config.yml"
APP_CONFIG = YAML.load_file(CONFIG_PATH)[Rails.env]