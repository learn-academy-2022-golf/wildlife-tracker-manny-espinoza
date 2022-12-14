require 'rails_helper'

RSpec.describe Animal, type: :model do
  it 'is not valid without a common name' do
    fish = Animal.create scientific_binomial:"Galeocerdo Cuvier"
    expect(fish.errors[:common_name]).to_not be_empty
  end
  it 'is not valid without a scientific binomial' do
    fish = Animal.create common_name:"Tiger Shark"
    expect(fish.errors[:scientific_binomial]).to_not be_empty
  end
  it 'is not valid if common name and scientific binomial are the same' do
    fish = Animal.create common_name:"Tiger Shark", scientific_binomial:"Tiger Shark"
    expect(fish.errors[:common_name]).to_not be_empty
  end
  it 'is not valid if common name is not unique' do
    Animal.create common_name:"Tiger Shark", scientific_binomial:"Galeocerdo Cuvier"
    fish = Animal.create common_name:"Tiger Shark", scientific_binomial:"Galeocerdo Cuvier"
    expect(fish.errors[:common_name]).to_not be_empty
  end
  it 'is not valid if scientific binomial is not unique' do
    Animal.create common_name:"Tiger Shark", scientific_binomial:"Galeocerdo Cuvier"
    fish = Animal.create common_name:"Tiger Shark", scientific_binomial:"Galeocerdo Cuvier"
    expect(fish.errors[:scientific_binomial]).to_not be_empty
  end
end
