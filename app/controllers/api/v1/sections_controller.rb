class Api::V1::SectionsController < ApplicationController
  def index
    @sections = Section.includes(:subject, :teacher, :classroom).all # TODO: pagination
    render json: @sections, each_serializer: SectionSerializer
  end

  def show
    @section = Section.find(params[:id])
    render json: @section, serializer: SectionSerializer
  end
end
