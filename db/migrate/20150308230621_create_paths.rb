class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.references :point1, index: true
      t.references :point2, index: true
      t.decimal :distance

      t.timestamps null: false
    end
    add_foreign_key :paths, :point1s
    add_foreign_key :paths, :point2s
  end
end
