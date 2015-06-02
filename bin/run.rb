require_relative '../db/setup'
require_relative '../lib/user'
# Remember to put the requires here for all the classes you write and want to use

def parse_params(method, uri_fragments, query_param_string)
  params = {}
  params[:resource]  = uri_fragments[3]
  params[:id]        = uri_fragments[4]
  params[:action]    = uri_fragments[5]
  if query_param_string
    case method
    when "POST" || "PUTS"
      param_pairs = query_param_string.split(',')
      param_k_v   = param_pairs.map { |param_pair| param_pair.split(':') }
      param_k_v.each { |k, v| params.store(k.to_sym, v) }
    else
      param_pairs = query_param_string.split('&')
      param_k_v   = param_pairs.map { |param_pair| param_pair.split('=') }
      param_k_v.each { |k, v| params.store(k.to_sym, v.delete('"')) }
    end
  end
  params
end

def parse(raw_request)
  pieces = raw_request.split(' ')
  method = pieces[0]
  case method
  when "POST" || "PUTS"
    route  = pieces[1]
    query_param_string = pieces[2].delete("'")
    http_v = pieces[3]
  else
    uri    = pieces[1]
    http_v = pieces[2]
    route, query_param_string = uri.split('?')
  end




  uri_fragments = route.split('/')
  protocol = uri_fragments[0][0..-2]
  full_url = uri_fragments[2]
  subdomain, domain_name, tld = full_url.split('.')
  params = parse_params(method, uri_fragments, query_param_string)
  return {
    method: method,
    uri: uri,
    http_version: http_v,
    protocol: protocol,
    subdomain: subdomain,
    domain_name: domain_name,
    tld: tld,
    full_url: full_url,
    params: params
  }
end

system('clear')
loop do
  print "Supply a valid HTTP Request URL (h for help, q to quit) > "
  raw_request = gets.chomp

  case raw_request
  when 'q' then puts "Goodbye!"; exit
  when 'h'
    puts "A valid HTTP Request looks like:"
    puts "\t'GET http://localhost:3000/students HTTP/1.1'"
    puts "Read more at : http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html"
  else
    system('clear')
    REQUEST = parse(raw_request)
    PARAMS  = REQUEST[:params]
    # Use the REQUEST and PARAMS constants to full the request and
    # return an appropriate reponse

    # YOUR CODE GOES BELOW HERE


    resources_string = PARAMS[:resource].capitalize.chop
    resource_class = resources_string.constantize
    resources = resource_class.new
    response = []

    case REQUEST[:method]
    when "GET"
      response << resources.get(PARAMS)
    when "DELETE"
      resource_class.find(PARAMS[:id].to_i).destroy
      response << "-" * `tput cols`.chomp.to_i
      response << "#{resources_string.downcase + PARAMS[:id]} Succesfully Deleted"
      response << "-" * `tput cols`.chomp.to_i
      response << "Response Code: 200"
      response << "-" * `tput cols`.chomp.to_i
      response << " "
    when "POST"
      response.post(PARAMS)
    when "PUT"

    else
      response << "-" * `tput cols`.chomp.to_i
      response << "Not Found LOL"
      response << "-" * `tput cols`.chomp.to_i
      response << "Response Code: 404"
      response << "-" * `tput cols`.chomp.to_i
      response << " "
    end
    response.join("\n")
    puts response
    # YOUR CODE GOES ABOVE HERE  ^
  end
end
