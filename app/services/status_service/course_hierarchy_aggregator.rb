module StatusService
  class CourseHierarchyAggregator
    def initialize(course)
      @course = course
    end

    def build
      @values ||= { Course: [course.id], Space: spaces_ids,
                    Lecture: lectures_ids }
    end

    private

    attr_accessor :course

    def spaces_ids
      course.spaces.pluck(:id)
    end

    def lectures_ids
      subjects_ids = Subject.where(space_id: spaces_ids).pluck(:id)
      Lecture.by_subjects(subjects_ids).pluck(:id)
    end
  end
end
