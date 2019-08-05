class ActivitiesController < ApplicationController

    def add_activity_to_user
        if current_user != nil
            params = add_activity_to_user_params
            activity = Activity.find params[:id]
            current_user.activities << activity
        end
    end

    def add_activity_to_user_params
        params.permit(:id)
    end

end
