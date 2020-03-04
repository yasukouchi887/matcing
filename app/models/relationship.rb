class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  
  has_one :rooms
  
  # enum status: { not_accept: 1, accept: 2 }
end
