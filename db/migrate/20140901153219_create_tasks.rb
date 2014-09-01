class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :uuid, limit: 36, null: false
      t.string :task_type, null: false
      t.string :status, null: false
      t.integer :point, null: false
      t.string :title, null: false
      t.text :description
      t.integer :position
      t.datetime :started_at
      t.datetime :finished_at
      t.references :user, null: false
      t.timestamps
    end
    add_index :tasks, :uuid, unique: true
  end
end
