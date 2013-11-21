class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /.+@.+\..+/ }
  validates :name, presence: true, length: { maximum: 32 }
end
