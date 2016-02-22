class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.text :resource_url

      t.timestamps null: false
    end
  end
end
