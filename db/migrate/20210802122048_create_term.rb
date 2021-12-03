class CreateTerm < ActiveRecord::Migration[6.1]
  def change
    create_table :terms do |t|
      t.string :source_term, null: false
      t.string :target_term, null: false
      t.references :glossary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
