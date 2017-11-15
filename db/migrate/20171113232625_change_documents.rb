class ChangeDocuments < ActiveRecord::Migration[5.0]
  def change
    change_column :documents, :body, :text
  end
end
