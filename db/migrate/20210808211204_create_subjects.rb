class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      #default abaixo é um modificador de coluna
      t.string :description, null: false

      t.timestamps
    end
  end
end
