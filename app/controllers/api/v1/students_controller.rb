class Api::V1::StudentsController < ApplicationController
  before_action :set_student

  def schedule
    @schedule = @student.sections.includes(:subject, :teacher, :classroom)
    render json: @schedule
  end

  # POST /api/v1/students/:id/sections/:section_id
  def add_section
    section = Section.find(params[:section_id])

    @student.sections << section

    head :created
  end

  def remove_section
    section = Section.find(params[:section_id])
    @student.sections.delete(section)
    head :no_content
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end
end
