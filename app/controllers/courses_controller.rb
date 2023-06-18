class CoursesController < ApplicationController
  def index
    @courses = Course.all
    @domain = "main"
  end

  def search
    if params[:search].blank?
      redirect_to(root_path) and return
    else
      @parameter = params[:search].downcase
      @courses = Course.all.where("lower(name) LIKE :search OR lower(short_name) LIKE :search", search: "%#{@parameter}%")
      @events = Event.all.where("lower(title) LIKE :search", search: "%#{@parameter}%")

      @domain = "search"
    end
  end

  def show
  end

  def new
    @course = Course.new
    @domain = "modify"
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def course_params
      params.require(:course).permit(:name, :semester, :year, :period, :short_name, :faculty, :lecturer, :room)
    end
end
