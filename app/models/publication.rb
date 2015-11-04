class Publication < ActiveRecord::Base
  validates :name, presence: true,
                   length: { minimum: 5 }

  validates :country, presence: true,
                   length: { minimum: 5 }

  validates :province, presence: true,
                   length: { minimum: 5 }

  validates :locality, presence: true,
                   length: { minimum: 5 }

  validates :address, presence: true,
                   length: { minimum: 5 }

  validates :status, presence: true,
                   length: { minimum: 5 }

end
