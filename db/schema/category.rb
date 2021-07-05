# frozen_string_literal: true

create_table :categories, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin' do |t|
  t.string :label, null: false
  t.bigint :user_id, null: false
  t.boolean :is_public, null: false, default: true

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false
end

add_index :categories, :user_id, using: :btree
add_foreign_key :categories, :users, column: :user_id
