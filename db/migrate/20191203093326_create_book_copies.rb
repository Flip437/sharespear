class CreateBookCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :book_copies do |t|
      t.string :title
      t.string :author
      t.text :description
      t.integer :status
      t.string :category
      t.string :isbn
      t.string :photo_link, default: ""
      t.belongs_to :user, index: true #cette ligne rajoute la référence à la table users

      t.timestamps
    end
  end
end
