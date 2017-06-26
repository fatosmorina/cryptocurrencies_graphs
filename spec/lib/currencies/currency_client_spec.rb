require "rails_helper"
require "#{Rails.root}/lib/currencies/currency_client.rb"

describe CurrencyClient do
	
	context "when communicating with external services" do
		it 'returns Bitcoins successfully' do
			expect_successful_response('bitcoin', "Sun, 18 Jun 2017 00:00:00 +0000", 2560.21)
		end

		it 'returns Ethereums successfully' do
			expect_successful_response('ethereum', "Tue, 20 Jun 2017 00:00:00 +0000", 362.65)
		end

		it 'returns Nasdaq values successfully' do
			expect_successful_response('nasdaq', "Fri, 16 Jun 2017 05:00:00 +0000", 6151.76)
		end
	end


private

  def expect_successful_response(currency, date, value)
	allow(RestClient).to receive(:get).and_return(send("get_successful_#{currency}_response"))
	response = CurrencyClient.send("get_#{currency}s")
	expect(response.keys[0]).to eq(date)
	expect(response.values[0]).to eq(value)
  end

  def get_successful_bitcoin_response
  	{
  		"Data": [
        {
            "time": 1497744000,
            "close": 2560.21,
            "high": 2676.04,
            "low": 2570.81,
            "open": 2655.1,
            "volumefrom": 27323.02,
            "volumeto": 71535198.81
        }
     ]
  	}.to_json
   end

   def get_successful_ethereum_response
  	{
  		"Data": [
       {
            "time": 1497916800,
            "close": 362.65,
            "high": 365.13,
            "low": 356.94,
            "open": 358.2,
            "volumefrom": 106370.4,
            "volumeto": 38429650.7
        }
     ]
  	}.to_json
   end

   def get_successful_nasdaq_response
   	{
   	"seriess": [
        {
            "obs": [
                [
                    1497589200000,
                    6151.76
                ],
               ]
            }
        ]
   	}.to_json
   end

end