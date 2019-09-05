class Post < ApplicationRecord
  belongs_to :user

  has_many :commentaries, dependent: :destroy
  has_many :stars, dependent: :destroy
  validates :title, :content, presence: true

end
