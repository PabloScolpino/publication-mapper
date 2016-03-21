class MapsController < ApplicationController
  def index
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'Lat' )
    data_table.new_column('number', 'Lon' )
    data_table.new_column('string', 'Name')
    data_table.add_rows( publications )

    @chart = GoogleVisualr::Interactive::Map.new(data_table, map_options)
  end

  private

  def publications
    Publication.all.approved.collect do |publication|
      [publication.latitude, publication.longitude, publication.name]
    end
  end

  def map_options
    { showTip: true,
      mapType: 'normal',
      icons: {
        default: {
          normal: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Azure-icon.png',
          selected: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Right-Azure-icon.png'
        }
      }
    }
  end

  def icons

  end
end
