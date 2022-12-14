require 'rails_helper'

RSpec.describe Sighting, type: :model do
  it 'is not valid without latitude' do
    sight1 = Sighting.create longitude:100, date:"2022-12-12"
    expect(sight1.errors[:latitude]).to_not be_empty
  end
  it 'is not valid without longitude' do
    sight1 = Sighting.create latitude:100, date:"2022-12-12"
    expect(sight1.errors[:longitude]).to_not be_empty
  end
  it 'is not valid without date' do
    sight1 = Sighting.create latitude:100, longitude:100
    expect(sight1.errors[:date]).to_not be_empty
  end
end
