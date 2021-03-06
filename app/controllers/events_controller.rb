class EventsController < ApplicationController

  before_action :authenticate_member!, except: [:show, :index]
  load_and_authorize_resource
  skip_authorize_resource :only => [:show, :index]

  def index
    @events = Event.all.order(:start_time)
    @event = Event.new

    @upcoming_events = Event.where('start_time >= ?', DateTime.now).order(:start_time)
    @past_events = Event.where('start_time < ?', DateTime.now).order(:start_time)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path 
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

    def event_params
      params.require(:event).permit(
        :name,
        :description,
        :start_time,
        :end_time,
        :has_end
      )
    end

end
