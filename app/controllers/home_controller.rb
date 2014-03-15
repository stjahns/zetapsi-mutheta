class HomeController < ApplicationController
  def index

    @content = content_for("home")

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
    @content = EditableContent.find_by name: params[:name]
    @content.content = params[:content][:editable][:value]
    unless @content.save
      flash.now[:error] = "Failed to save content for some reason."
    end
    render text: ""
  end

  private
    def content_for(content_name)
      content = EditableContent.find_by name: content_name

      if content.nil?
        content = EditableContent.new
        content.name = content_name
        content.save
      end

      return content
    end
end
