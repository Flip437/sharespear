class CreateBorrows < ActiveRecord::Migration[5.2]
  def change
    create_table :borrows do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.text :message
      t.string :borrow_status, default: Borrow::PENDING
      t.references :borrower_user, references: :users, foreign_key: { to_table: :users }
      t.references :borrowed_user, references: :users, foreign_key: { to_table: :users}
      t.belongs_to :book_copy, index: true #cette ligne rajoute la référence à la table book_copies

      t.timestamps
    end
  end
end
