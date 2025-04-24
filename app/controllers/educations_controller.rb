# -*- encoding : utf-8 -*-
class EducationsController < ApplicationController
  respond_to :js

  load_resource :user
  load_and_authorize_resource :education, :through => :user

  def create
    @high_school = HighSchool.new
    @higher_education = HigherEducation.new
    @complementary_course = ComplementaryCourse.new
    @event_education = EventEducation.new

    if params.has_key? :high_school
      educationable = HighSchool.new(params.require(:high_school).permit(:institution, :'end_year(1i)', :'end_year(2i)', :'end_year(3i)', :description))
      @high_school = educationable
    elsif params.has_key? :higher_education
      educationable = HigherEducation.new(higher_education_params)
      @higher_education = educationable
    elsif params.has_key? :complementary_course
      educationable = ComplementaryCourse.new(complementary_course_params)
      @complementary_course = educationable
    elsif params.has_key? :event_education
      educationable = EventEducation.new(params.require(:event_education).permit(:name))
      @event_education = educationable
    end

    @education = Education.new
    @education.user = current_user
    @education.educationable = educationable
    @education.save

    if @education.valid?
      @high_school = HighSchool.new
      @higher_education = HigherEducation.new
      @complementary_course = ComplementaryCourse.new
      @event_education = EventEducation.new
    else
      @high_school ||= HighSchool.new
      @higher_education ||= HigherEducation.new
      @complementary_course ||= ComplementaryCourse.new
      @event_education ||= EventEducation.new
    end

    respond_with(@user, @education)
  end

  def update
    if params.has_key? :high_school
      @education.educationable.attributes = params.require(:high_school).permit(:institution)
      @high_school = HighSchool.new
    elsif params.has_key? :higher_education
      @education.educationable.attributes = params.require(:higher_education).permit(:institution)
      @higher_education = HigherEducation.new
    elsif params.has_key? :complementary_course
      @education.educationable.attributes = params.require(:complementary_course).permit(:institution)
      @complementary_course = ComplementaryCourse.new
    elsif params.has_key? :event_education
      @education.educationable.attributes = params.require(:event_education).permit(:name)
      @event_education = EventEducation.new
    end
    @education.educationable.save

    respond_with(@user, @education)
  end

  def destroy
    @education.destroy

    respond_with(@user, @education)
  end

  private

  def higher_education_params
    permitted_params = %i[
      kind
      course
      institution
      start_year(1i)
      start_year(2i)
      start_year(3i)
      end_year(1i)
      end_year(2i)
      end_year(3i)
      description
    ]

    params.require(:higher_education).permit(permitted_params)
  end

  def complementary_course_params
    permitted_params = %i[
      course
      institution
      workload
      year(1i)
      year(2i)
      year(3i)
      description
    ]

    params.require(:complementary_course).permit(permitted_params)
  end
end
