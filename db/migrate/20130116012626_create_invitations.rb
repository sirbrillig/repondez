class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|

      t.timestamps
    end
    add_column :guests, :invitation_id, :integer
  end
end
