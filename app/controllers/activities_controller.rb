class ActivitiesController < ApplicationController

    def add_activity_to_user
        if current_user != nil
            activity = Activity.find params[:id]
            user = User.find current_user.id
            current_user.follow(activity)
        end
    end

    def remove_activity_from_user
        if current_user != nil
            activity = Activity.find params[:id]
            current_user.stop_following(activity)
        end
    end

    def get_activity_list
        
        @our_activities = []

        current_user.all_follows.each do |followable|
            activity = Activity.find followable.followable_id
            @our_activities.push(activity)
        end

        @all_activities = (Activity.all.to_a - @our_activities)

        render json: {our_activities: @our_activities, all_activities: @all_activities }
    end

end
