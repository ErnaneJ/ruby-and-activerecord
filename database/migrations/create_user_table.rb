# ./database/migrations/create_user_table.rb

require './configurations/initializer.rb'

class CreateUserTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.string :email
      t.boolean :admin
      t.string :tshirt_size
      t.timestamps
    end
  end
end

CreateUserTable.migrate(:up)
