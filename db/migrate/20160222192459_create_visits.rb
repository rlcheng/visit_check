class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :name
      t.float :time

      t.timestamps null: false
    end
  end
end
