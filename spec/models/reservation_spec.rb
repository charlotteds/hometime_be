require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "relationships" do
    it {is_expected.to belong_to(:guest)}
  end

  describe "validations" do
    subject { build :reservation }
    it {is_expected.to validate_uniqueness_of(:code).ignoring_case_sensitivity}
  end
end
