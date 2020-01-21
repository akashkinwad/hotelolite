module ArenasService
  extend self

  def matches(params)
    params = URI.encode_www_form(params.to_unsafe_h)
    send_request("matches.json?event_type=cricket&#{params}")
  end

  def match(match_id)
    send_request("matches/#{match_id}/show2.json?play_status=in_play&event_type=cricket.json")
  end

  def tournaments
    send_request('tournaments')
  end

  def tournament(id)
    send_request("tournaments/#{id}")
  end

  private

    def send_request(path)
      JSON.parse(
        RestClient.get("#{arenas_base_url}/#{path}", 'Api-Key': ARENAS_API_KEY)
      )
    rescue => e
      {
        message: "Something went wrong, please contact administration for more details",
        status: 500
      }
    end

    def arenas_base_url
      Rails.application.config.arenas_rest_url
    end
end
