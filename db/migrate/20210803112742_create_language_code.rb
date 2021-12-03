class CreateLanguageCode < ActiveRecord::Migration[6.1]
  def change
    create_table :language_codes do |t|
      t.string :code
      t.string :country

      t.timestamps
    end
  end
end
