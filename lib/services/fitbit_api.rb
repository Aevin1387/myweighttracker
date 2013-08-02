class FitbitApi
  attr_reader :connection
  def initialize(oauth_token, token_secret, consumer_key, consumer_secret)
    @connection = Faraday.new "https://api.fitbit.com" do |con|

      con.request :oauth, { token: oauth_token, token_secret: token_secret, consumer_key: consumer_key, consumer_secret: consumer_secret }
      con.request :url_encoded

      con.adapter Faraday.default_adapter
    end
  end

  def log_weight(date, weight)
    @connection.post do |req|
      req.url '/1/user/-/body/log/weight.json'
      req.body= { weight: weight, date: date.to_s }
      req.headers["Accept-Language"] = "en_US"
    end
  end

  def log_fat(date, fat)
    @connection.post do |req|
      req.url '/1/user/-/body/log/fat.json'
      req.body= { fat: fat, date: date.to_s  }
      req.headers["Accept-Language"] = "en_US"
    end
  end
end
