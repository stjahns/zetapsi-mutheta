class HomeController < ApplicationController

  before_action :authenticate_member!,  only: [:mercury_update]

  def index
    @content = content_for("home")

    @cover_album = Album.first

    # Get upcoming events
    @events = Event.where('start_time >= ?', DateTime.now).order(:start_time)
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
