class Player < ActiveRecord::Base
  has_and_belongs_to_many :teams

  validates :name, presence: true
  validates :name, uniqueness: true 
  validates :name, length: { maximum: 32 }
end
