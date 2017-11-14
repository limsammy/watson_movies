class CreateTones < ActiveRecord::Migration[5.0]
  def change
    create_table :tones do |t|
      t.string :tone_id
      t.float :tone_score
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
