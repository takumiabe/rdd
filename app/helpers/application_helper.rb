module ApplicationHelper

  def decorate(str)
    DomainModel.all.pluck(:name, :id).sort_by{|name| -name.size }.each do |name, id|
      b = content_tag(:b, link_to(name, domain_model_path(id)))
      str = str.gsub(name, b)
    end

    domain_models = DomainModel.all.index_by(&:id)
    str = str.gsub(/\$domain:(\d+)\$/) do |match|
      if dm = domain_models[$1.to_i]
        link_to dm.name, dm
      else
        "$error$"
      end
    end
    str = str.gsub("\n", "<br/>")
    str.html_safe
  end
end
