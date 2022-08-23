class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


    def create 
        lease = Lease.create!(lease_params)
        render json: lease, status: :accepted
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def destroy
        lease = Lease.find_by!(id: params[:id])
        lease.destroy
        render json: {}
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def render_not_found_response
        render json: {error: "Lease not found"}, status: :not_found
    end
end
