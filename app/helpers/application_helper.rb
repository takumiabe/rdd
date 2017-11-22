module ApplicationHelper

  def decorate(str)
    DomainModel.all.pluck(:name, :id).sort_by{|name| -name.size }.each do |name, id|
      b = content_tag(:b, link_to(name, domain_model_path(id)))
      str = str.gsub(name, b)
    end
    simple_format str
  end
end
