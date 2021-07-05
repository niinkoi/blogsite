# frozen_string_literal: true

create_table :posts, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin' do |t|
  t.string :title, null: false
  t.string :short_description
  t.text :content, null: false
  t.bigint :user_id, null: false
  t.bigint :category_id, null: false
  t.bigint :thread_id
  t.boolean :is_public, null: false, default: true

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false
end

add_index :posts, %i[user_id], name: 'index_user_on_post', using: :btree
add_index :posts, %i[category_id], name: 'index_category_on_post', using: :btree
add_index :posts, %i[thread_id], name: 'index_thread_on_post', using: :btree
add_foreign_key :posts, :users, column: :user_id
add_foreign_key :posts, :categories, column: :category_id
add_foreign_key :posts, :posts, column: :thread_id

