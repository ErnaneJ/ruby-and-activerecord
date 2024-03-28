# ./models/post.rb
class Post < ActiveRecord::Base
  belongs_to :user
end