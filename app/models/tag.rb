class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :publications, through: :taggings
end
