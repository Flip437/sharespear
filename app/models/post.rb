class Post < ApplicationRecord
    belongs_to :book_copy
    belongs_to :user
    has_many :comments
end
