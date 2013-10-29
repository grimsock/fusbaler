class Player < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true 
  validates :name, length: { maximum: 32 }
end
