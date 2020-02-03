class Post < ApplicationRecord
    belongs_to :book_copy
    belongs_to :user
end
