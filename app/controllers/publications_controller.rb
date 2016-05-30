class PublicationsController < ApplicationController
  before_action :authenticate_user!, only: [ :review ]
  before_action :grab_publication, only: [ :update, :show, :edit, :approve, :revoke, :destroy]
  before_action :grab_publications, only: [ :index, :review, :map ]
  before_action :grab_map_options, only: [ :map ]
  before_action :grab_map_options_single, only: [ :update, :show, :edit ]
  before_action :grab_map_points, only: [ :map ]
  before_action :grab_map_points_single, only: [ :update, :show, :edit ]
  before_action :grab_chart, only: [ :update, :show, :edit, :map ]

  def map
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: @publications }
    end
  end

  def review
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
      redirect_to edit_publication_path(@publication)
    else
      render :edit
    end
  end

  def show
  end

  def edit
    grab_chart
    @tags = Tag.all
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
    params.require( :publication ).permit( :name, :description,
                                           :address, :country, :province, :locality,
                                           :latitude, :longitude,
                                           :icon_tag_id, tag_ids: [])
  end

  def grab_publication
    @publication = Publication.find(params[:id])
  end

  def grab_publications
    @publications = Publication.all.order(:name) if current_user
    @publications ||= Publication.all.approved.order(:name)
  end

  def grab_map_points
    @map_points = @publications.select{ |p| p.latitude != nil and p.longitude!= nil }.collect do |p|
      p.google_chart_point
    end
  end

  def grab_map_points_single
    @map_points = [ @publication.google_chart_point ]
  end

  def grab_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'Lat' )
    data_table.new_column('number', 'Lon' )
    data_table.new_column('string', 'Name')
    data_table.new_column('string', 'Marker')

    data_table.add_rows( @map_points )

    @chart = GoogleVisualr::Interactive::Map.new(data_table, @map_options)
  end

  def grab_map_options_single
    @map_options = { showTip: true,
                     mapType: 'normal',
                     zoomLevel: 12,
                     icons: Tag.map_icons
                    }
  end

  def grab_map_options
    @map_options = { showTip: true,
                     mapType: 'light_dream',
                     icons: Tag.map_icons,
                     maps: {
                       light_dream: {
                         name: 'Blue Map Style',
                         styles: [{"featureType":"landscape.natural","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#e0efef"}]},{"featureType":"poi","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"hue":"#1900ff"},{"color":"#c0e8e8"}]},{"featureType":"road","elementType":"geometry","stylers":[{"lightness":100},{"visibility":"simplified"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"visibility":"on"},{"lightness":700}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#7dcdcd"}]}]
                       }
                     }
                   }
  end
end
