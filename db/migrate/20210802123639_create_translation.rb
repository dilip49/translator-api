class CreateTranslation < ActiveRecord::Migration[6.1]
  def change
    create_table :translations do |t|
      t.string :source_language_code, null: false
      t.string :target_language_code, null: false
      t.text :source_text, null: false, limit: 5000
      t.references :glossary, foreign_key: true

      t.timestamps
    end
  end
end
