class CallsController < ApplicationController
  get '/calls' do
    @calls = Call.time_sorted
    erb :'calls/index'
  end

  get '/calls/recent' do
    @calls = Call.this_week.time_sorted
    erb :'calls/recent'
  end

  post '/calls' do
    if logged_in?
      @call = Call.new params
      if @call.save
        flash[:message] = ["Your call to #{@call.rep_name} was saved successfully!"]
        redirect '/calls/recent'
      else
        flash[:message] = @call.errors.full_messages
        redirect "/calls/new/#{params[:office_id]}"
      end
    else
      redirect '/login'
    end
  end

  patch '/calls' do
    call = Call.find params[:id]

    # Don't allow the patch unless the user is logged_in and is the current_user
    redirect '/login' unless current_user == call.user

    if call.update params[:call]
      call_anchor = "#{params[:path]}#call#{call.id}-card"
      call_link = "<a href='#{call_anchor}'>here</a>"
      flash[:message] = ["Your review was successfully updated. View it #{call_link}."]
    else
      flash[:message] = call.errors.full_messages
    end

    redirect params[:path] || "/users/#{current_user.slug}"
  end

  get '/calls/new/:office_id' do
    @office = OfficeLocation.find params[:office_id]
    erb :'calls/new'
  end
end
