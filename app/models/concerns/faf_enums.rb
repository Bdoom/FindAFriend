# frozen_string_literal: true

module FafEnums
  extend ActiveSupport::Concern

  included do
    enum viewability_levels:
    {
      everyone: 0,
      only_me: 1,
      friends_only: 2
    }
  end
end
