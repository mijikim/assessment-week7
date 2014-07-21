class Messages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.string :username
      t.string :messages
    end
  end

  def down
    drop_table :messages
  end
end
