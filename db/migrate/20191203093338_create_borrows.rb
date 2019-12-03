class CreateBorrows < ActiveRecord::Migration[5.2]
  def change
    create_table :borrows do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.text :message
      t.integer :borrow_status
      t.belongs_to :user, index: true #cette ligne rajoute la référence à la table users
      t.belongs_to :book_copy, index: true #cette ligne rajoute la référence à la table book_copies

      t.timestamps
    end
  end
end
