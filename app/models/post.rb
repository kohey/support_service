class Post < ApplicationRecord
  belongs_to :user
  has_many :post_payments
  validates :content, presence: true, length: { maximum: 255 }
end
