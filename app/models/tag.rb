class Tag < ApplicationRecord
  has_many :taggings
  has_many :publications, through: :taggings

  has_attachment :icon, accept: [:png]

  def self.map_icons
    icons = {
      default: {
        normal: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Azure-icon.png',
        selected: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Azure-icon.png',
      }
    }
    Tag.all.each do |tag|
      if tag.icon?
        icons[tag.icon_name] = {
          normal: tag.cl_icon_url,
          selected: tag.cl_icon_url
        }
      end
    end
    icons
  end

  def icon_name
    self.name.gsub(/\s+/,'_')
  end

  def cl_icon_url
    Cloudinary::Utils::cloudinary_url(
          'pin',
          secure: true,
          transformation: { size: '60x90', crop: :scale },
          overlay: self.icon.public_id,
          size: '40x40', gravity: 'north', y: 5   )
  end
end
