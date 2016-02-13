class PublicationsController < ApplicationController
  before_action :grab_publication, only: [ :update, :show, :edit, :approve, :revoke]

  def index
    @publications = Publication.all.approved
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

  def approve
    @publication.approved_at = DateTime.now()
    @publication.save!
    render :edit
  end

  def revoke
    @publication.approved_at = nil
    @publication.save!
    render :edit
  end

  private
  def publication_params
    params.require( :publication ).permit( :name, :description, :address, :country, :province, :locality, :latitude, :longitude)
  end

  def grab_publication
    @publication = Publication.find(params[:id])
  end
end
