class PublicationsController < ApplicationController
  before_action :grab_publication, only: [ :update, :show, :edit, :approve, :revoke, :destroy]
  before_action :grab_chart, only: [ :update, :show, :edit ]

  def index
    @publications = Publication.all.approved.order(:id)
    #@publications = Publication.all if current_user

    respond_to do |format|
      format.html
      format.json { render json: @publications }
    end
  end

  def review
    @publications = Publication.all.order(:id)
    #@publications = Publication.all if current_user

    respond_to do |format|
      format.html
      format.json { render json: @publications }
    end
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)
    if @publication.save
      redirect_to '/publications'
    else
      render :new
    end
  end

  def update
    if @publication.update(publication_params)
      #redirect_to '/publications'
      redirect_to edit_publication_path(@publication)
    else
      render :edit
    end
  end

  def show
  end

  def edit
    grab_chart
  end

  def approve
    @publication.approved_at = DateTime.now()
    @publication.save!
    redirect_to :publication_review
  end

  def revoke
    @publication.approved_at = nil
    @publication.save!
    redirect_to :publication_review
  end

  def destroy
    @publication.destroy!
    redirect_to :publication_review
  end

  private

  def publication_params
    params.require( :publication ).permit( :name, :description, :address, :country, :province, :locality, :latitude, :longitude)
  end

  def grab_publication
    @publication = Publication.find(params[:id])
  end

  def grab_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'Lat' )
    data_table.new_column('number', 'Lon' )
    data_table.new_column('string', 'Name')
    map_point = [ @publication.latitude,
                  @publication.longitude,
                  @publication.name ]
    data_table.add_rows( [ map_point ] )


    @chart = GoogleVisualr::Interactive::Map.new(data_table, map_options)
  end

  def map_options
    { showTip: true,
      mapType: 'normal',
      zoomLevel: 12,
      icons: {
        default: {
          normal: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Azure-icon.png',
          selected: 'http://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Right-Azure-icon.png'
        }
      }
    }
  end
end
