# frozen_string_literal: true

create_table :bonds, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin' do |t|
  t.bigint :user_id, null: false
  t.bigint :friend_id, null: false
  t.string :state, null: false

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false
end

add_index :bonds, %i[user_id], name: 'index_bonds_on_user_id', using: :btree
add_index :bonds, %i[friend_id], name: 'index_bonds_on_friend_id', using: :btree
add_foreign_key :bonds, :users, column: :user_id
add_foreign_key :bonds, :users, column: :friend_id

