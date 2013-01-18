class Guest < ActiveRecord::Base
  attr_accessible :first_name, :last_name
  belongs_to :invitation
  has_many :answers
end
