class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.references :user, index: true, null: false
      t.timestamps
    end
  end
end
