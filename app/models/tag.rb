class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :publications, through: :taggings

  has_attachment :icon, accept: [:png]
end
