class AboutUsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_about_us, only: [:index, :edit, :update]

  # GET /about_us
  # GET /about_us.json
  def index
  end

  # GET /about_us/1/edit
  def edit
  end

  # PATCH/PUT /about_us/1
  # PATCH/PUT /about_us/1.json
  def update
    respond_to do |format|
      if @about_us.update(about_us_params)
        format.html { redirect_to about_us_path, notice: 'Acerca de nosotros actualizado exitosamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_about_us
      @about_us = AboutU.first
      if not @about_us.nil?
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
        @body = markdown.render(@about_us.body)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def about_us_params
      params.require(:about_u).permit(:body)
    end
end
