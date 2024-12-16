module Api
  module V1
    class PlacesController < ApplicationController
      before_action :find_place, only: %i[show update destroy]

      def index
        @places = Place.includes(:images)
        render json: @places
        # render json: @places.as_json(include: :images)
        # render json: @places.map { |place| place.as_json(include: :images) }
      end

      def create
        @place = Place.new(place_params)
        if @place.save
          render json: @place, status: 200, message: "place created successfully"
        else
          render json: @place.errors.full_messages.to_sentence, status: :unprocessable_entity
        end
      end

      def show
        # render json: @place.as_json(include: :images)
        render json: @place.as_json(include: { images: { only: [:id, :url] } })
      end

      def update
        if @place.update(place_params)
          render json: @place, status: 200, message: "place updated successfully"
        else
          render json: @place.errors.full_messages.to_sentence, status: :unprocessable_entity
        end
      end

      def destroy
         if @place.destroy
          render json: @place, status: 200, message: "place deleted successfully"
        else
          render json: @place.errors.full_messages.to_sentence, status: :unprocessable_entity
        end
      end

      private
      def find_place
        @place = Place.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { message: e.message, status: "failed" }
      end

      def place_params
        params.require(:place).permit(:name, :description, :latitude, :longitude, :city, :state, :country, :image_url, images_attributes: [:id, :url])
      end
    end
  end
end
