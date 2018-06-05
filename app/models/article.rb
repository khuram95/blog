class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
	has_many :article_tags
  has_many :tags, through: :article_tags  
  
  validates :title, presence: true, length: { minimum: 5, maximum: 300 }
  validates :description, presence: true, length: { minimum: 10, maximum: 3000 } 
  validates :user_id, presence: true
end