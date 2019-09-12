class Star < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum star_status: { 
    without_star: 0, 
    with_star: 1
  }

  def star_count post_id
    Star.where("star_status = ? AND post_id = ?", 1, post_id).count
  end

  def change_rated
    if self.with_star?
      self.without_star!
    else
      self.with_star!
    end
  end
end
