class Api::V1::ParseReservationParamsService < ApplicationService
  VALID_KEYS = ["code", "start_date", "end_date", "nights", "guests", "adults", "children", "infants", "status", "currency", "payout", "security", "total", "first_name", "last_name", "phone", "email"].freeze

  def initialize args
    @raw_params = args
  end

  def perform
    flattened_params = flatten(@raw_params).deep_symbolize_keys
    {
      guest: {
        first_name: flattened_params[:first_name],
        last_name: flattened_params[:last_name],
        email: flattened_params[:email],
        phone_numbers_attributes: build_phone_numbers(flattened_params[:phone])
      },
      reservation: {
        code: flattened_params[:code],
        start_date: flattened_params[:start_date],
        end_date: flattened_params[:end_date],
        nights: flattened_params[:nights],
        guests_count: flattened_params[:guests],
        adults_count: flattened_params[:adults],
        children_count: flattened_params[:children],
        infants_count: flattened_params[:infants],
        status: flattened_params[:status],
        currency: flattened_params[:currency],
        payout_price: flattened_params[:payout],
        security_price: flattened_params[:security],
        total_price: flattened_params[:total]
      }
    }
  end

  def update_key(key) # check if key is permitted
    VALID_KEYS.find { |s| key.to_s.include?(s) }
  end

  def flatten(data) # flatten json
    data.each_with_object({}) do |(key, value), reservation|
      if value.instance_of?(ActiveSupport::HashWithIndifferentAccess)
        flatten(value).each { |k, v| reservation[update_key(k)] = v unless k.nil? }
      else
        reservation[update_key(key)] = value unless key.nil?
      end
    end
  end

  def build_phone_numbers(phone_numbers)
    phone_numbers.instance_of?(String) ? [{ value: phone_numbers }] : phone_numbers.each_with_object([]) { |num, numbers| numbers << { value: num } }
  end
end
