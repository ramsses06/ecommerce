class CreateMyemails < ActiveRecord::Migration
  def change
    create_table :myemails do |t|
      t.string :email
      t.string :ip
      t.integer :state, default: 0

      t.timestamps null: false
    end
  end
end
