require 'sinatra'
require 'docker'

set server: 'thin'
set :bind, '0.0.0.0'

Docker.options = { read_timeout: 5 }

get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/events', provides: 'text/event-stream' do

  stream :keep_open do |out|
    begin
      Docker::Event.stream do |event|
        out << "data: {\n"
        out << "data: \"id\": \"#{event.id}\",\n"
        out << "data: \"status\": \"#{event.status}\",\n"
        out << "data: \"from\": \"#{event.from}\",\n"
        out << "data: \"time\": #{event.time}\n"
        out << "data: }\n\n"
      end
    rescue Docker::Error::TimeoutError
      out.close
    end
  end
end
