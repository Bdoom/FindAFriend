# frozen_string_literal: true

class AddGenderAndSexualityAndReligionToUserInfo < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_infos, :gender, foreign_key: true
    add_reference :user_infos, :sexuality, foreign_key: true
    add_reference :user_infos, :religion, foreign_key: true
  end
end
