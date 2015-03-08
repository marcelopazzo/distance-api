class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :name
      t.references :location, index: true

      t.timestamps null: false
    end
    add_foreign_key :points, :locations
  end
end
