class RemovePostDefaultViewabilityFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :post_default_viewability_level
  end
end
