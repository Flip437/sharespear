class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content
      t.belongs_to :book_copy, index: true #cette ligne rajoute la référence à la table book_copies
      t.belongs_to :user, index: true #cette ligne rajoute la référence à la table book_copies

      t.timestamps
    end
  end
end
