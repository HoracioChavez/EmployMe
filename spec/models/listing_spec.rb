require 'rails_helper'

RSpec.describe Listing, :type => :model do
  let(:listing) do
    Listing.create!(
      title: 'Barista',
      description: 'Grinding dem beans',
      pay_rate: '8.00/hr',
      employment_type: 'part-time',
      number_of_positions: 1,
      closing_date: Time.new(2014, 9, 24, 12, 0, 0),
    )
  end

  it 'is valid' do
    expect(listing).to be_valid
  end

  it 'is invalid without a title' do
    listing.title = nil
    expect(listing).not_to be_valid
  end

  it 'is invalid without a description' do
    listing.description = nil
    expect(listing).not_to be_valid
  end

  it 'is invalid without a job_type' do
    listing.employment_type = nil
    expect(listing).not_to be_valid
  end

  #make a test for not allowing a less than 1 positions open


end
