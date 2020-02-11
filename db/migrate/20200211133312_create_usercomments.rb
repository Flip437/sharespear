class CreateUsercomments < ActiveRecord::Migration[5.2]
  def change
    create_table :usercomments do |t|
      t.string :content
      t.integer :status, default: 1
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
