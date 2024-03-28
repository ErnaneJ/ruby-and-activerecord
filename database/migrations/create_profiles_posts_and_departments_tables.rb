# ./database/migrations/create_profiles_posts_and_departments_tables.rb

require './configurations/initializer.rb'

class CreateProfilesPostsAndDepartmentTables < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :bio
    end

    create_table :posts do |t|
      t.integer :user_id
      t.text :content
    end

    create_table :departments do |t|
      t.string :name
    end

    create_table :departments_users do |t|
      t.integer :user_id
      t.integer :department_id
    end
  end
end

CreateProfilesPostsAndDepartmentTables.migrate(:up)