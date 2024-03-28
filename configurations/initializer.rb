# configurations/initializer.rb
require 'yaml'
require 'active_record'

db_config = YAML::load(File.open(Dir.pwd + '/configurations/database.yaml'))

ActiveRecord::Base.establish_connection(db_config)