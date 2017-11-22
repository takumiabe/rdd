class DomainModel < ApplicationRecord

  def requirements_ref
    [
      Requirement.where('condition like ?', "%#{placeholder}%"),
      Requirement.where('description like ?', "%#{placeholder}%"),
      Requirement.where('remark like ?', "%#{placeholder}%")
    ].inject(:or)
  end

  def requirements
    [
      Requirement.where('condition like ?', "%#{name}%"),
      Requirement.where('description like ?', "%#{name}%"),
      Requirement.where('remark like ?', "%#{name}%")
    ].inject(:or)
  end

  def placeholder
    "$domain:#{id}$"
  end

  def replace!
    transaction do
      requirements.each do |r|
        r.update!(condition: r.condition.gsub(name, placeholder))
        r.update!(description: r.description.gsub(name, placeholder))
        r.update!(remark: r.remark.gsub(name, placeholder))
      end
    end
  end
end
