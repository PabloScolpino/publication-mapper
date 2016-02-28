class PublicationsController < ApplicationController
  before_action :grab_publication, only: [ :show, :update, :edit ]

  def index
    @publications = Publication.all

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
      render 'new'
    end
  end

  def update
    if @publication.update(publication_params)
      redirect_to '/publications'
    else
      render 'edit'
    end
  end

  def show
  end

  def edit
  end

  private

  def publication_params
    params.require( :publication ).permit( :name, :description, :address, :country, :province, :locality, :latitude, :longitude)
  end

  def grab_publication
    @publication = Publication.find(params[:id])
  end
end
