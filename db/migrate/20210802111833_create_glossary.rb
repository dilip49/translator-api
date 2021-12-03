class CreateGlossary < ActiveRecord::Migration[6.1]
  def change
    create_table :glossaries do |t|
      t.string :source_language_code, null: false
      t.string :target_language_code, null: false

      t.timestamps
    end

    add_index :glossaries, [:source_language_code, :target_language_code], { name: 'index_language_code' }
  end
end
