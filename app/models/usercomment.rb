class Usercomment < ApplicationRecord
    belongs_to :commenter, class_name: "User"
    belongs_to :commented, class_name: "User"
end
