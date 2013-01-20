class Question < ActiveRecord::Base
  attr_accessible :label, :field_type, :options
  has_many :answers
end
