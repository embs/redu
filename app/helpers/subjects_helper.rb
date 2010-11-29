module SubjectsHelper

  # Adiciona novos campos dinamicamente
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,
                          :child_index => "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name,
                     h("add_fields(this, \"#{association}\"," + \
                       "\"#{escape_javascript(fields)}\")"))
  end

  def existent_spaces
    @course.spaces.collect { |s| [s.name, s.id] }
  end

  def user_assets
    assets = current_user.lectures.collect do |l|
      [l.name, "#{l.id.to_s}-Lecture"]
    end
    assets += current_user.exams.collect do |l|
      [l.name, "#{l.id.to_s}-#{l.class.to_s}"]
    end
  end
end
