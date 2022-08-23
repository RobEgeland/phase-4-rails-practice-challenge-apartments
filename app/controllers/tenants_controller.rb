class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        tenants = Tenant.all 
        render json: tenants, status: :ok
    end

    def show
        tenant = Tenant.find_by!(id: params[:id])
        render json: tenant, status: :ok
    end

    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def update
        tenant = Tenant.find_by!(id: params[:id])
        tenant.update(tenant_params)
        render json: tenant, status: :accepted
    end

    def destroy
        tenant = Tenant.find_by!(id: params[:id])
        tenant.destroy
        render json: {}
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: {error: "Tenant not found"}, status: :not_found
    end

end
