class Invitation < ActiveRecord::Base
  has_many :guests

  def guest_list
    return 'none' if guests.empty?
    guests.collect { |g| g.full_name }.join ', '
  end
end
