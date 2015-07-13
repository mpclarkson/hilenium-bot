# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

   lulz = ['lol', 'rofl', 'lmao']

   robot.hear /lulz/i, (res) ->
     res.send res.random lulz

   robot.hear /launch/i, (res) ->
     res.send "Hopefully we'll launch sometime before 2020..."

   heys = ['hi', 'hello', 'hey']

   robot.hear /heys/i, (res) ->
     res.send res.random heys

   process.env.HUBOT_WEATHER_API_URL ||=
     'http://api.openweathermap.org/data/2.5/weather'
   process.env.HUBOT_WEATHER_UNITS ||= 'imperial'

   robot.hear /weather in (\w+)/i, (msg) ->
     city = msg.match[1]
     query = { units: process.env.HUBOT_WEATHER_UNITS, q: city }
     url = process.env.HUBOT_WEATHER_API_URL
     msg.robot.http(url).query(query).get() (err, res, body) ->
       data = JSON.parse(body)
       weather = [ "#{Math.round(data.main.temp)} degrees" ]
       for w in data.weather
         weather.push w.description
       msg.reply "It's #{weather.join(', ')} in #{data.name}, #{data.sys.country}"

