class PhonesController < ApplicationController
	PHONE_NUMBER_RANGE = (1111111111..9999999999)

	def index
		@phone = Phone.all? 
		render json: @phone
	end

	def show
		render :json => Phone.all.pluck(:number)
	end

	def phone_get
		@phone = Phone.create(number: number_generate)
		if @phone.save
			render json: {status: "CREATED", message: "created", data: @phone}, status: :ok
		else
			render json: {status: "ERROR", message: "ERROR 500", data: @phone}, status: :ok
		end
	end

	def phone_custom
		@phone = Phone.new(number: params["number"])
		if number_duplicate(@phone.number)
			render json: {status: "ERROR", message: "number already in use", data: @phone}, status: :ok
		elsif number_in_range
			@phone.save
			render json: {status: "CREATED", message: "created", data: @phone}, status: :ok
		end
	end

	def number_generate
		@number = rand PHONE_NUMBER_RANGE
		number_duplicate(@number) ? number_generate : @number
	end

	def number_in_range
		PHONE_NUMBER_RANGE.include?(@phone.number) ? true : false
	end

	def number_duplicate(number)
		Phone.where(number: number).exists? ? true : false
	end
end
