require 'rack/request'
require 'rack/response'
require 'haml'
  
module RockPaperScissors
  class App 
 
    def initialize(app = nil)
      @app = app
      @content_type = :html
      @defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'}
      @throws = @defeat.keys
      @choose = @throws.map { |x| 
           %Q{ <li><a href="/?choice=#{x}">#{x}</a></li> }
        }.join("\n")
      @choose = "<p>\n<ul>\n#{@choose}\n</ul>"
    end
  
    def call(env)
      req = Rack::Request.new(env)
 
      req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }
 
      computer_throw = @throws.sample
      player_throw = req.GET["choice"]
      answer = if !@throws.include?(player_throw)
          ""
        elsif player_throw == computer_throw
          "<b>Result:</b> You tied with the computer"
        elsif computer_throw == @defeat[player_throw]
          "<b>Result:</b> Nicely done; #{player_throw} beats #{computer_throw}"
        else
          "<b>Result:</b> Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!"
        end
      if !answer.empty?
        answer.insert(0, "<b>Your choice:</b> #{player_throw}, <b>Computer choice:</b> #{computer_throw}, ")
      end
      engine = Haml::Engine.new File.open("views/index.haml").read 
      res = Rack::Response.new
      res.write engine.render({}, 
          :answer => answer, 
          :choose => @choose,
          :throws => @throws)
        res.finish
      end # call
    end   # App
  end     # RockPaperScissors
  
if $0 == __FILE__
    require 'rack'
    Rack::Server.start(
      :app => RockPaperScissors::App.new, 
      :Port => 9292,
      :server => 'thin'
    )
end
