class Guest < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :invitation_id
  belongs_to :invitation
  has_many :answers

  def full_name
    "#{first_name} #{last_name}"
  end
end
