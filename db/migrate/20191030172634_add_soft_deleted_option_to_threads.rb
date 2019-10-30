class AddSoftDeletedOptionToThreads < ActiveRecord::Migration[5.2]
  def change
    add_column :board_threads, :soft_deleted, :boolean, default: false
  end
end
