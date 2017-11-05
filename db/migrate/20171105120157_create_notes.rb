class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :msg
      t.string :url

      t.timestamps
    end
  end
end
