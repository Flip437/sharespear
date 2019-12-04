class Borrow < ApplicationRecord
  attr_accessor :duree
  belongs_to :book_copy
  belongs_to :user
end
