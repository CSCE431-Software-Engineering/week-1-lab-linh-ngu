class Book < ApplicationRecord
    validates :title, presence: true
    validates :position, presence: true
    validates :author, presence: true
    validates :price, presence: true
    validates :published_date, presence: true
end
