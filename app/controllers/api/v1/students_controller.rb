class Api::V1::StudentsController < ApplicationController
  before_action :set_student, only: [ :schedule, :add_section, :remove_section, :download_schedule ]

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

  # GET /api/v1/students/:id/download_schedule
  def download_schedule
    @schedule = @student.sections.includes(:subject, :teacher, :classroom)

    pdf = Prawn::Document.new
    pdf.text "Schedule for #{@student.first_name}", size: 20, style: :bold
    pdf.move_down 20

    @schedule.each do |section|
      pdf.text "Subject: #{section.subject.name}"
      pdf.text "Time: #{I18n.l(section.start_time, format: :time)} - #{I18n.l(section.end_time, format: :time)}"
      pdf.text "Days: #{section.days.join(', ')}"
      pdf.text "Teacher: #{section.teacher.first_name} #{section.teacher.last_name}"
      pdf.text "Classroom: #{section.classroom.name}"
      pdf.move_down 10
    end

    send_data pdf.render, filename: "#{@student.first_name}_schedule.pdf", type: "application/pdf", disposition: "inline"
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
