class IndexController < ApplicationController
  def index
    current_semester = @current_user.year.current_semester
    if current_semester
      @new_materials = Material.where(subject_id: current_semester.subjects).order('updated_at DESC').limit(10)
    else
      @new_materials = Material.all.order('updated_at DESC').limit(10)
    end
    if @current_user.year.ml_account
      @ml_archives = @current_user.year.ml_account.ml_archives.order('sent_at DESC').limit(3)
    else
      @ml_archives = []
    end
  end

  def calendar
  end

  def help
  end

  # delete me
  def vocabulary
  end
end
