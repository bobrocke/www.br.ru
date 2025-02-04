class CreateColors < ActiveRecord::Migration[8.0]
  def change
    create_table :colors do |t|
      t.string :hex
      t.integer :r
      t.integer :g
      t.integer :b
      t.integer :h
      t.integer :s
      t.integer :l

      t.timestamps
    end
  end
end
