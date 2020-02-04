class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :like,  default: 0
      t.integer :status, default: 1
      t.belongs_to :book_copy, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
