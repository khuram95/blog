class Tag < ApplicationRecord
	has_many :article_tags
  has_many :articles, through: :article_tags
    
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }, uniqueness: true
  validates_uniqueness_of :name
end
