# frozen_string_literal: true

create_table :users, force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin' do |t|
  t.string :first_name, null: false
  t.string :last_name
  t.string :username, null: false
  t.string :email, null: false

  t.datetime :created_at, null: false
  t.datetime :updated_at, null: false
end

