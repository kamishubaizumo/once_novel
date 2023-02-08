class CreateNovels < ActiveRecord::Migration[6.1]
  def change
    create_table :novels do |t|


      t.string :title, null: false
      t.text :body, null: false
      t.integer :user_id, null: false

      t.integer :novel_status, null: false, default: 0
      t.text :foreword
      t.text :afterword
      t.string :logline


      t.timestamps
    end
  end
end
