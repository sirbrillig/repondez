class Guest < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :invitation_id
  belongs_to :invitation
  has_many :answers

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_by_first_name_and_last_name(first_name, last_name)
    Guest.where('lower(first_name) = ? AND lower(last_name) = ?', first_name.downcase, last_name.downcase).first
  end
end
