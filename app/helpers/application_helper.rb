module ApplicationHelper
  def display_date date
    date.strftime("%Y-%m-%d")
  end

  def link_to_add_fields(name, f, class_name)
    new_object = eval(class_name.classify).new
    id = new_object.object_id
    fields = f.fields_for(class_name, new_object, index: id) do |builder|
      render( class_name+"_form", builder: builder)
    end
    link_to(name, '#', class: "btn add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
