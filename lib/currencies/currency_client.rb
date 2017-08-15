module CurrencyClient
  def self.get_bitcoins
    get_currencies(APP_CONFIG.fetch('bitcoin_api_url'))
  end

  def self.get_ethereums
    get_currencies(APP_CONFIG.fetch('ethereum_api_url'))
  end

  def self.get_nasdaqs
    json = get_json_response(APP_CONFIG.fetch('nasdaq_api_url'))
    values = json['seriess'].first['obs']
    values.inject({}) do |new_element, current_element|
      key = DateTime.strptime((current_element[0] / 1000).to_s, '%s')
      value = current_element[1]
      new_element[key] = value
      new_element
    end
  end

private

  def self.get_currencies(api_url)
    json_response = get_json_response(api_url)
    json_response['Data'].inject({}) do |new_element, current_element|
      key = DateTime.strptime(current_element['time'].to_s, '%s')
      value = current_element['close']
      new_element[key] = value
      new_element
    end
  end

  def self.get_json_response(api_url)
    response = RestClient.get(api_url)
    json = JSON.parse(response)
    json
  end
end
