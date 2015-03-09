class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.references :point1, index: true
      t.references :point2, index: true
      t.decimal :distance, :precision => 10, :scale => 2

      t.timestamps null: false
    end
    add_foreign_key :paths, :points, column: :point1_id
    add_foreign_key :paths, :points, column: :point2_id
  end
end
