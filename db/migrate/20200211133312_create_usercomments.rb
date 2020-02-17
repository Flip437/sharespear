class CreateUsercomments < ActiveRecord::Migration[5.2]
  def change
    create_table :usercomments do |t|
      t.string :content
      t.integer :status, default: 1
      t.references :commented, index: true
      t.references :commenter, index: true

      t.timestamps
    end
  end
end
