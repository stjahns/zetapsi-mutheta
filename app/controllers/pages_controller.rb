class PagesController < ApplicationController

  def show
    if params[:name]
      @page = Page.find_by_name(params[:name])
      redirect_to pages_path if @page.nil?
    else
      @page = Page.find(params[:id])
    end
  end

  def create
    @page = Page.new(page_params)
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
    page = Page.find(params[:id])
    page.content = params[:content][:page_content][:value]
    unless page.save
      flash.now[:error] = "Failed to save!"
    end
    render text: ""
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to pages_path
  end

  private 

    def page_params
      params.require(:page).permit( :name, :content )
    end

end
