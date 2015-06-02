class User < ActiveRecord::Base

  def get(params)
    @response_code = "200"
    @response = []
    @response << "-" * `tput cols`.chomp.to_i
    id, string, limit, offset = [params[:id], params.fetch(:first_name, "%"), params.fetch(:limit, - 1).to_i, params.fetch(:offset, 0).to_i]

    if id
      if user = User.find_by(id: id)
        get_all([user])
      else
        @response_code = "404"
        @response << "Not Found LOL"
        @response << "-" * `tput cols`.chomp.to_i
      end
    else
      get_by_params(string, limit, offset)
    end

    @response << "Response Code: #{@response_code}"
    @response << "-" * `tput cols`.chomp.to_i
    @response << " "
    @response.join("\n")
  end

  def get_by_params(string, limit, offset)
    user_matches = User.where("first_name LIKE ?", "#{string}%").limit(limit).offset(offset)
    get_all(user_matches)
  end

  def get_all(users)
    users.each_with_index do |user|
    @response << "user" + user.id.to_s + ":"
    user.attributes.each do |k, v|
      @response << "   #{k} => #{v}"
    end
    @response << "-" * `tput cols`.chomp.to_i
    end
  end
end
