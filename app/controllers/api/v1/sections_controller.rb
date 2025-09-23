class Api::V1::SectionsController < ApplicationController
  def index
    @sections = Section.includes(:subject, :teacher, :classroom).all # TODO: pagination
    render json: @sections, each_serializer: SectionSerializer
  end

  def show
    @section = Section.find(params[:id])
    render json: @section, serializer: SectionSerializer
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      render json: @section, serializer: SectionSerializer, status: :created
    else
      render json: { errors: @section.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def section_params
    params.require(:section).permit(:subject_id, :classroom_id, :teacher_id, :start_time, :end_time, days: [])
  end
end
