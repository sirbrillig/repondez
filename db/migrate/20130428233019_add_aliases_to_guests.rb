class AddAliasesToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :alias_first_name, :string
    add_column :guests, :alias_last_name, :string
  end
end
