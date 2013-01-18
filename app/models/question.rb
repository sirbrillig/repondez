class Question < ActiveRecord::Base
  attr_accessible :label, :field_type
  has_many :answers
end
