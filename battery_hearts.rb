#!/usr/bin/env ruby
# encoding: utf-8

full    = "\u{1f49a}"
empty   = "\u{1f499}"
battery = "\u{1f50b}"
plug    = "\u{26a1}"
warn    = "\u{26a0}"
hrtspk  = "\u{1f496}"
spark   = "\u{2728}"
star    = "\u{2b50}"
plugin  = "\u{1f50c}"
goldhrt = "\u{1f49b}"
nope    = "\u{1f6ab}"

charging = false

star_count = 10
per_star = 100/star_count

v= Hash.new()

ARGF.each do |a|
  if a.start_with? "Now"
    #this is Now for os x 10.9 other versions may be somthing else
    if a =~ /'(.*)'/
      v[:source] = $~[1]
    else
      v[:source] = ""
    end
  elsif a.start_with?" -"
    if a =~ /(\d{1,3})%;\s(.*);\s(\d:\d{2}|\(no estimate\))/
      v[:percent] = $~[1].to_i
      v[:state]   = $~[2]
      v[:time]    = $~[3]
    else
      v[:percent] = "0"
      v[:state]   = "unknown"
      v[:time]    = "unknown"
    end
  end
end

outstring = ""

if v[:source]== "Battery Power"
  charging = false
  outstring += "#{battery} "
else
  charging = true
  outstring +="#{plug} "
end

full_stars  = v[:percent] / per_star + 1
empty_stars = star_count - full_stars

full_stars.times do
  if v[:percent] > 94 && charging
    outstring += "#{hrtspk}"
  elsif v[:percent] < 10
    outstring += "#{nope}"
  elsif charging
    outstring += "#{goldhrt} "
  else
    outstring += "#{full} "
  end
end

empty_stars.times do
  if v[:percent] < 10
    outstring += "#{nope}"
  elsif charging
    outstring += "#{spark} "
  else
    outstring += "#{empty} "
  end
end

if v[:time] == "0:00"
  outstring += "             charged"
elsif v[:percent] < 10
  outstring += "            #{v[:percent]}% "
elsif v[:time] == "(no estimate)"
  #add nothing
else
  outstring += " #{v[:time]}"
end

puts outstring
