# VK-Console

Ruby wrapper for vk.com API 

## Install

`gem install vk-console`

## How to use?
```.ruby
irb 
ruby-1.9.2-p290 :001 > require 'vk-console'
ruby-1.9.2-p290 :006 > console = VK::Console.new :app_id => 'APP_ID', 
                                                 :email => 'example@gmail.com', 
                                                 :password => 'you_password', 
                                                 :logger => $STDOUT, 
                                                 :debug => false
 => #<VK::Console:0x00000002147600 @logger=nil, @debug=false, ........
 
ruby-1.9.2-p290 :007 > console.isAppUser
 => "1" 
console.friends.get
 => [1729061, 3369964, 4638502, 5138714, 6242991, 75145 .....
console.audio.search(:q => 'sting').each{|track| puts track.inspect}
212993
{"aid"=>"116741294", "owner_id"=>"58377004", 
                     "artist"=>"Sting", 
                     "title"=>"Englishman In New York  ", 
                     "duration"=>"269", 
                     "url"=>"http://cs4768.vkontakte.ru/u42849027/audio/07b6ef7dfd9d.mp3", 
                     "lyrics_id"=>"16729834"}
{"aid"=>"116487251", "owner_id"=>"4719192", 
                     "artist"=>"Sting", 
                     "title"=>"Until...", 
                     "duration"=>"190", 
                     "url"=>"http://cs5048.vkontakte.ru/u4719192/audio/7febac4a2ed8.mp3"}
....
```

## Examples

 https://github.com/zinenko/vk-console/tree/master/example

## Tests

Coming soon!

## Contributing to vk-ruby
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Andrew Zinenko. See LICENSE.txt for
further details.
