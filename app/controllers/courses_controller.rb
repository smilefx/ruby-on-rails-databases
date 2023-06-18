class CoursesController < ApplicationController
  def index
    @courses = Course.all
    @events = Event.all.where("date >= ?", Date.today).order(date: :asc, time: :asc)
    @domain = "main"
  end

  def search
    if params[:search].blank?
      redirect_to(root_path) and return
    else
      @parameter = params[:search].downcase
      @courses = Course.all.where("lower(name) LIKE :search OR lower(short_name) LIKE :search", search: "%#{@parameter}%")
      @events = Event.all.where("date >= ?", Date.today).order(date: :asc, time: :asc).where("lower(title) LIKE :search OR course_id IN (:course_id)", search: "%#{@parameter}%", course_id: @courses.ids)

      @domain = "search"
    end
  end

  def show
    @course = Course.find(params[:id])
    @events = @course.events.all.where("date >= ?", Date.today).order(date: :asc, time: :asc)
    @domain = "detail"
  end

  def new
    @course = Course.new
    @domain = "modify"
  end

  def create
    @course = Course.new(course_params)
    @domain = "modify"

    if @course.save
      redirect_to @course
    else
      render :new, status: :unprocessable_entity, :domain => "modify"
    end
  end

  def edit
    @course = Course.find(params[:id])
    @domain = "modify"
  end

  def update
    @course = Course.find(params[:id])
    @domain = "modify"

    if @course.update(course_params)
      redirect_to @course
    else
      render :edit, status: :unprocessable_entity, :domain => "modify"
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def course_params
      params.require(:course).permit(:name, :semester, :year, :period, :short_name, :faculty, :lecturer, :room)
    end
end
