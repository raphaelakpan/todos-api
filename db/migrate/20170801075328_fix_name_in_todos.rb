class FixNameInTodos < ActiveRecord::Migration[5.0]
  def change
    rename_column :todos, :name, :title
  end
end
