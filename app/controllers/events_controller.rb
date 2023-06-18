class EventsController < ApplicationController
  def show
    @course = Course.find(params[:course_id])
    @event = @course.events.where("id = ?", params[:id].to_i).first
    @domain = "detail"
  end

  def new
    @course = Course.find(params[:course_id])
    @event = @course.events.new
    @domain = "modify"
  end

  def create
    @course = Course.find(params[:course_id])
    @event = @course.events.new(event_params)
    @domain = "modify"

    if @event.save
      redirect_to course_event_path(@course, @event)
    else
      render :new, status: :unprocessable_entity, :domain => "modify"
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @event = @course.events.where("id = ?", params[:id].to_i).first
    @domain = "modify"
  end

  def update
    @course = Course.find(params[:course_id])
    @event = @course.events.where("id = ?", params[:id].to_i).first
    @domain = "modify"

    if @event.update(event_params)
      redirect_to course_event_path(@course, @event)
    else
      render :edit, status: :unprocessable_entity, :domain => "modify"
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @event = @course.events.where("id = ?", params[:id].to_i).first
    @event.destroy
    redirect_to @course, status: :see_other
  end

  private
    def event_params
      params.require(:event).permit(:title, :date, :time, :status)
    end
end
