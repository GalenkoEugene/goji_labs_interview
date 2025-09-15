class Api::V1::StudentsController < ApplicationController
  before_action :set_student, only: [ :schedule, :add_section, :remove_section ]

  def index
    @students = Student.all # TODO: pagination
    render json: @students, each_serializer: StudentSerializer
  end

  def schedule
    @schedule = @student.sections.includes(:subject, :teacher, :classroom)
    render json: @schedule, each_serializer: SectionSerializer
  end

  # POST /api/v1/students/:id/sections/:section_id
  def add_section
    section = Section.find(params[:section_id])

    result = EnrollStudent.call(student: @student, section: section)

    if result.success?
      render json: result.enrollment, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
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
