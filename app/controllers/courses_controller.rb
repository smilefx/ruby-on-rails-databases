class CoursesController < ApplicationController
  # Index-Aktion: Lädt alle Kurse und Events und zeigt sie an
  def index
    @courses = Course.all
    @events = Event.all.where("date >= ?", Date.today).order(date: :asc, time: :asc)
    @domain = "main"
  end

  # Search-Aktion: Lädt alle Kurse und Events, die den Suchbegriff enthalten und zeigt sie an
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




  # =====  TODO - Beispielaufgabe 2  =====
  #      
  # · Ersetze das nil durch einen Datenbankaufruf, sodass der passende Kurs in die Variable "@course" geladen und angezeigt wird
  # · Der Aktionsaufruf erfolgt über die URL "/courses/:id"

  def show
    @course = nil

    # Hier drunter muss nichts geändert werden
    if @course.nil?
      redirect_to root_path, status: :see_other
    elsif
      @events = @course.events.all.where("date >= ?", Date.today).order(date: :asc, time: :asc)
      @domain = "detail"
    end
  end

  # ======================================



  # New-Aktion: Lädt ein leeres Kurs-Objekt und zeigt Formular an
  def new
    @course = Course.new
    @domain = "modify"
  end

  # Create-Aktion: Speichert ein neues Kurs-Objekt in der Datenbank
  def create
    @course = Course.new(course_params)
    @domain = "modify"

    if @course.save
      redirect_to @course
    else
      render :new, status: :unprocessable_entity, :domain => "modify"
    end
  end

  # Edit-Aktion: Lädt ein Kurs-Objekt und zeigt Werte in Formular an
  def edit
    @course = Course.find(params[:id])
    @domain = "modify"
  end

  # Update-Aktion: Speichert ein geändertes Kurs-Objekt in der Datenbank
  def update
    @course = Course.find(params[:id])
    @domain = "modify"

    if @course.update(course_params)
      redirect_to @course
    else
      render :edit, status: :unprocessable_entity, :domain => "modify"
    end
  end

  # Destroy-Aktion: Löscht ein Kurs-Objekt aus der Datenbank
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    redirect_to root_path, status: :see_other
  end

  # Definiert die erlaubten Parameter für die Create- und Update-Aktionen
  private
    def course_params
      params.require(:course).permit(:name, :semester, :year, :period, :short_name, :faculty, :lecturer, :room)
    end
end
