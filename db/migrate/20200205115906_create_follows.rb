class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.belongs_to :user, index: true
      t.integer :follow_user_id
      t.boolean :active, default: 1

      t.timestamps
    end
  end
end
