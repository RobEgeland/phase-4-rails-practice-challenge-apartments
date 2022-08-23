class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


    def index 
        apartments = Apartment.all 
        render json: apartments, status: :ok 
    end

    def show
        apartment = Apartment.find_by!(id: params[:id])
        render json: apartment, status: :ok
    end

    def create 
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def update
        apartment = Apartment.find_by!(id: params[:id])
        apartment.update(apartment_params)
        render json: apartment, status: :accepted
    end

    def destroy 
        apartment = Apartment.find_by!(id: params[:id])
        apartment.destroy
        render json: {}
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def render_not_found_response
        render json: {error: "Apartment not found"}, status: :not_found
    end
end
