class HomeController < ApplicationController

  before_action :check_logged_in,  only: [:mercury_update]

  def index
    @content = content_for("home")

    @cover_album = Album.first

    # Get upcoming events
    @events = Event.where('time >= ?', DateTime.now).order(:time)
  end

  def about
    @content = content_for("about")
  end

  def contact
    @content = content_for("contact")
  end

  def mercury_update
    mercury_update_footer
    @content = EditableContent.find_by name: params[:name]
    @content.content = params[:content][:editable][:value]
    unless @content.save
      flash.now[:error] = "Failed to save content for some reason."
    end
    render text: ""
  end

end
