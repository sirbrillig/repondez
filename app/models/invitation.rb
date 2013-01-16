class Invitation < ActiveRecord::Base
  has_many :guests
end
