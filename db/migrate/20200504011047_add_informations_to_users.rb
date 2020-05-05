class AddInformationsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :user_name, :string, null: false
    add_column :users, :website, :string
    add_column :users, :self_introduction, :text
    add_column :users, :phone_number, :string
    add_column :users, :sex, :string
  end
end
