class ActivitiesController < ApplicationController

    def add_activity_to_user
        if current_user != nil
            activity = Activity.find params[:id]
            user = User.find current_user.id
            user.like!(activity)
        end
    end

    def remove_activity_from_user
        if current_user != nil
            activity = Activity.find params[:id]
            user = User.find current_user.id

            user.unlike!(activity)
        end
    end

    def get_activity_list
        @our_activities = []
        user = User.find current_user.id

        Activity.all.each do |activity|
            if user.likes?(activity)
                @our_activities.push(activity)
            end
        end

        @all_activities = (Activity.all.to_a - @our_activities)

        render json: {our_activities: @our_activities, all_activities: @all_activities }
        
    end

end
