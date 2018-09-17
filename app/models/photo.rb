class Photo < ApplicationRecord
  belongs_to :album
  validates :title, presence: false, length: { maximum: 24 }

end
