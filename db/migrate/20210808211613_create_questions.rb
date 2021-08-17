class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      #default abaixo é um modificador de coluna
      t.text :description, null: false
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
