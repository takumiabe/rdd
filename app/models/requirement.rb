class Requirement < ApplicationRecord
  extend Enumerize

  has_many :proposals

  enumerize :status, in: %i[in-review fixed]
end
