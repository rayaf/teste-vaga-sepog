class Commentary < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :commentary_text, presence: true
end
