class CreateQuizSubmissions < ActiveRecord::Migration[8.1]
  def change
    create_table :quiz_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true
      t.text :answer

      t.timestamps
    end
  end
end
