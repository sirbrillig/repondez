class Guest < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :invitation_id, :alias_first_name, :alias_last_name
  belongs_to :invitation
  has_many :answers

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_by_first_name_and_last_name(first_name, last_name)
    Guest.where('(lower(first_name) = :first OR lower(alias_first_name) LIKE :alias_first) AND (lower(last_name) = :last OR lower(alias_last_name) LIKE :alias_last)', {first: first_name.downcase, last: last_name.downcase, alias_first: "%"+first_name.downcase+"%", alias_last: "%"+last_name.downcase+"%"}).first
  end
end
