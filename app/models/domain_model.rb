class DomainModel < ApplicationRecord

  def requirements
    [
      Requirement.where('condition like ?', "%#{name}%"),
      Requirement.where('description like ?', "%#{name}%"),
      Requirement.where('remark like ?', "%#{name}%")
    ].inject(:or)
  end
end
