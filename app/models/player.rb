class Player < ActiveRecord::Base
  validates :bnetid, uniqueness: true
end
