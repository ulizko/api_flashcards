class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.text     :original_text
      t.text     :translated_text
      t.datetime :review_date,                   null: false
      t.integer  :user_id,                       null: false
      t.integer  :interval,        default: 1,   null: false
      t.integer  :repeat,          default: 1,   null: false
      t.float    :efactor,         default: 2.5, null: false
      t.integer  :attempt,         default: 1,   null: false
      t.integer  :quality,         default: 5,   null: false
    end
  end
end
