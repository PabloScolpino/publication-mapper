class MapsController < ApplicationController
  def index
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'Lat' )
    data_table.new_column('number', 'Lon' )
    data_table.new_column('string', 'Name')
    data_table.add_rows(4)
    data_table.set_cell(0, 0, 37.4232   )
    data_table.set_cell(0, 1, -122.0853 )
    data_table.set_cell(0, 2, 'Work'      )
    data_table.set_cell(1, 0, 37.4289   )
    data_table.set_cell(1, 1, -122.1697 )
    data_table.set_cell(1, 2, 'University')
    data_table.set_cell(2, 0, 37.6153   )
    data_table.set_cell(2, 1, -122.3900 )
    data_table.set_cell(2, 2, 'Airport'   )
    data_table.set_cell(3, 0, 37.4422   )
    data_table.set_cell(3, 1, -122.1731 )
    data_table.set_cell(3, 2, 'Shopping'  )

    opts   =  { showTip: true,
                icons: {
                  default: {
                    normal: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Azure-icon.png',
                    selected: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Right-Azure-icon.png'
                  }
                }
              }
    @chart = GoogleVisualr::Interactive::Map.new(data_table, opts)
  end
end
