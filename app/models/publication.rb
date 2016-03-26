class Publication < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :tags

  validates :name, presence: true,
                   length: { minimum: 5 }

  scope :approved, -> { where( 'approved_at is not null and approved_at <= ?', DateTime.now() ) }

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  def full_address
    address + ', ' + locality + ', ' + province + ', ' + country
  end

  def full_address_changed?
    address_changed? || locality_changed? || province_changed? || country_changed?
  end
end
