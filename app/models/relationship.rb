class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User" # 'User' - this true source of the array returned by :followed_users (models/user.rb)


  validates :follower_id, presence: true
  validates :followed_id, presence: true

end
