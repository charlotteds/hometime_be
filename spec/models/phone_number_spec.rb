require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do
  describe "relationships" do
    it {is_expected.to belong_to(:guest)}
  end
end
