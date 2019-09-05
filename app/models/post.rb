class Post < ApplicationRecord
  belongs_to :user
  has_many :commentaries, dependent: :destroy
  # accepts_nested_attributes_for :commentaries, allow_destroy: true
end
