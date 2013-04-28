class Guest < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :invitation_id, :alias_first_name, :alias_last_name
  belongs_to :invitation
  has_many :answers

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_by_first_name_and_last_name(first_name, last_name)
    #FIXME: messy!!
    result = Guest.where('lower(first_name) = ? AND lower(last_name) = ?', first_name.downcase, last_name.downcase).first
    return result unless result.nil?
    result = Guest.where('lower(alias_first_name) LIKE ? AND lower(last_name) LIKE ?', "%"+first_name.downcase+"%", "%"+last_name.downcase+"%").first
    return result unless result.nil?
    result = Guest.where('lower(first_name) LIKE ? AND lower(alias_last_name) LIKE ?', "%"+first_name.downcase+"%", "%"+last_name.downcase+"%").first
    return result unless result.nil?
    result = Guest.where('lower(alias_first_name) LIKE ? AND lower(alias_last_name) LIKE ?', "%"+first_name.downcase+"%", "%"+last_name.downcase+"%").first
    return result
  end
end
