class PagesController < ApplicationController

  before_action :authenticate_member!, except: [:show, :index]

  def show
    @page = Page.find_by_name(params[:name])
    redirect_to pages_path if @page.nil?
  end

  def create
    @page = Page.new(page_params)
    @page.name = @page.name.downcase
    if @page.save
      redirect_to @page
    else
      render 'index'
    end
  end

  def index
    @pages = Page.all
    @page = Page.new
  end

  def mercury_update
    page = Page.find_by_name(params[:name])
    page.content = params[:content][:page_content][:value]
    unless page.save
      flash.now[:error] = "Failed to save!"
    end
    render text: ""
  end

  def destroy
    @page = Page.find_by_name(params[:name])
    @page.destroy
    redirect_to pages_path
  end

  private 

    def page_params
      params.require(:page).permit( :name, :content )
    end

end
