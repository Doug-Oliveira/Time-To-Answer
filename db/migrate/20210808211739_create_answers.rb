class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :description
      t.references :question, foreign_key: true
      #default abaixo é um modificador de coluna
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
