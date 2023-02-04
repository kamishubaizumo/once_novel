class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :user_id, null: false
      t.integer :novel_id, null: false
      t.text :comment
      t.float :star_rate


      t.timestamps
    end
  end
end
