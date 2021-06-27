class Api::V1::SearchController < ApplicationController
  user = User.find_by(api_key: search_params[:api_key])
  if user
    if search_params[:IATA_code].blank?
      render json: "please enter valid IATA code" , status: 422
    else
      user.searches.create!(search_params)
      search_results = SearchFacade.get_info(search_params)
      render json: SearchSerializer.new(roadtrip), status: 200
      sleep 1
    end
  else
    render json: "invalid credentials" , status: 422
    sleep 1
  end
end

private

def search_params
  params.permit(:IATA_code, :radius, :api_key)
end

end
