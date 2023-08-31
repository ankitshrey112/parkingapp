require 'rails_helper'

RSpec.describe GetNearestAvailabilities do
  describe '#execute' do
    context 'with valid attributes' do
      let(:attributes) { { latitude: 1.37326, longitude: 103.899, per_page: 10 } }

      it 'returns the correct number of carparks' do
        result = described_class.run(attributes)
        expect(result['list'].length).to eq(10)
      end
      
      it 'checks order of carparks sorted by distance' do
        result = described_class.run(attributes)
        
        result['list'].each_with_index do |carpark, ind|
          next if ind == 0

          expected = result['list'][ind - 1]['distance']
          expect(carpark['distance']).to be >= (expected)
        end
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { { } }

      it 'latitude and longitude both missing' do
        result = described_class.run(attributes)
        expect(result).not_to be_valid
      end

      let(:attributes) { { latitude: 1.37326 } }

      it 'longitude missing' do
        result = described_class.run(attributes)
        expect(result).not_to be_valid
      end

      let(:attributes) { { longitude: 1.37326 } }

      it 'latitude missing' do
        result = described_class.run(attributes)
        expect(result).not_to be_valid
      end

      let(:attributes) { { longitude: '1.37326', longitude: 103.899 } }

      it 'incorrect input tye for longitude' do
        result = described_class.run(attributes)
        expect(result).not_to be_valid
      end
    end
  end
end
