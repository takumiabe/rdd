module ApplicationHelper

  def decorate(str, options = {})
    is_text = options[:text]

    unless is_text
      DomainModel.all.pluck(:name, :id).sort_by{|name| -name.size }.each do |name, id|
        b = content_tag(:b, link_to(name, domain_model_path(id)))
        str = str.gsub(name, b)
      end
    end

    domain_models = DomainModel.all.index_by(&:id)

    str = str.gsub(/\$domain:(\d+)\$/) do |match|
      if dm = domain_models[$1.to_i]
        if is_text
          dm.name
        else
          link_to dm.name, dm
        end
      else
        "$error$"
      end
    end
    str = str.gsub("\n", "<br/>") unless is_text

    if is_text
      str
    else
      str.html_safe
    end
  end
end
