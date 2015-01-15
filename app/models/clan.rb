class Clan < ActiveRecord::Base
  validates :tag, uniqueness: true
end
