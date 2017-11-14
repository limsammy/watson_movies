class ChangeDocuments < ActiveRecord::Migration[5.0]
  def change
    change_column :documents, :body, :text
    remove_column :documents, :cover_letter_file_name
    remove_column :documents, :cover_letter_content_type
    remove_column :documents, :cover_letter_file_size
    remove_column :documents, :cover_letter_updated_at
  end
end
