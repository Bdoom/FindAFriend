class ActivitiesController < ApplicationController

    def add_activity_to_user
        if current_user != nil
            activity = Activity.find params[:id]
            current_user.activities << activity
            current_user.activities = current_user.activities.uniq
        end
    end

    def remove_activity_from_user
        if current_user != nil
            activity = Activity.find params[:id]
            current_user.activities.delete activity
        end
    end

    def get_activity_list
        @our_activities = current_user.activities.to_a
        @all_activities = (Activity.all.to_a - @our_activities)

        render json: {our_activities: @our_activities, all_activities: @all_activities }
        
    end

end
