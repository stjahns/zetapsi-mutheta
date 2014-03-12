class HomeController < ApplicationController
  def index
    # Get upcoming events
    @events = Event.where('time >= ?', DateTime.now).order(:time)
  end
end
