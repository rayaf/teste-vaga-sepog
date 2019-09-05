class Star < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum star_status: { 
    without_star: 0, 
    with_star: 1
  }

  def star_count
    Star.where(star_status: 1).count
  end
end
