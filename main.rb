# main.rb
require 'active_record'

require './configurations/initializer.rb'

require './models/user'
require './models/profile'
require './models/post'
require './models/department'

require './examples/listing_columns.rb'
require './examples/deleting_records.rb'
require './examples/creating_new_records.rb'
require './examples/updating_records.rb'
require './examples/finding_records.rb'
require './examples/validating_records.rb'
require './examples/testing_transactions.rb'
require './examples/relationships.rb'