class PublicationsController < ApplicationController

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
    @publication = Publication.find(params[:id])
    if @publication.update(publication_params)
      redirect_to '/publications'
    else
      render 'edit'
    end
  end

  def show
    @publication = Publication.find(params[:id])
  end

  def edit
    @publication = Publication.find(params[:id])
  end

  private
  def publication_params
    params.require( :publication ).permit( :name, :description, :address, :country, :province, :locality, :latitude, :longitude)
  end
end
