def destroy_if_older_than_one_month(object)
  if object.created_at < Date.today - 30
    object.destroy
  end
end

every :sunday, :at => '12am' do
  things_to_destroy = [Complaint, Message, User, Medium, VideoLink]
  things_to_destroy.each do |thing|
    thing.all.each {|one_thing| destroy_if_older_than_one_month(one_thing)}
  end
end

every :day, :at => '19:10' do
  things_to_destroy = [Complaint, Message, User, Medium, VideoLink]
  things_to_destroy.each do |thing|
    thing.all.each {|one_thing| destroy_if_older_than_one_month(one_thing)}
    puts "DESTROYED THE THING"
  end
end

every :hour do
  things_to_destroy = [Complaint, Message, User, Medium, VideoLink]
  things_to_destroy.each do |thing|
    thing.all.each {|one_thing| destroy_if_older_than_one_month(one_thing)}
    puts "DESTROYED THE THING"
  end
end

# Learn more: http://github.com/javan/whenever
