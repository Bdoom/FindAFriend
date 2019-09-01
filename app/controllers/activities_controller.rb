# frozen_string_literal: true

class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def add_activity_to_user
    unless current_user.nil?
      activity = Activity.find params[:id]
      current_user.like!(activity)
    end
  end

  def remove_activity_from_user
    unless current_user.nil?
      activity = Activity.find params[:id]
      current_user.unlike!(activity)
    end
  end

  def get_activity_list
    @our_activities = []

    Activity.all.each do |activity|
        if current_user.likes?(activity)
            @our_activities.push(activity)
        end
    end

    @all_activities = (Activity.all.to_a - @our_activities)

    render json: { our_activities: @our_activities, all_activities: @all_activities }
  end
end
