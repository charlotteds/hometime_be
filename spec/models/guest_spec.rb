require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe "relationships" do
    it {is_expected.to have_many(:phone_numbers).dependent(:destroy)}
    it {is_expected.to have_many(:reservations).dependent(:destroy)}
  end

  describe "validations" do
    it {is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity}
  end
end
