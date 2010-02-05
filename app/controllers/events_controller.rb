class EventsController < ApplicationController

  def index
    @service = GCal4Ruby::Service.new
    @service.authenticate("socialbiteevents@gmail.com", "elsol100")
    @calendars = @service.calendars
    @cal = GCal4Ruby::Calendar.find(@service, "socialbiteevents@gmail.com", {:scope => :first})
    @events = GCal4Ruby::Event.find(@cal, "",{ :range => {:start => Time.now, :end => 30.days.from_now}}).reverse
  end

end
