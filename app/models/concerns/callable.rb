module Callable
  def average_call_rating
    calls.average('rating').round(1)
  end

  def recent_calls
    calls.this_week
  end

  def recent_calls_count
    recent_calls.count
  end

  def calls_count
    calls.count
  end

  def no_calls?
    calls.blank?
  end

  def time_sorted_calls
    calls.time_sorted
  end

  def last_call
    calls.last_call
  end

  def last_call_time
    last_call.time
  end

  def calls_stars
    calls.stars
  end

  def percent_of_calls_connected
    (calls.that_connected.count.to_f / calls_count * 100).round(1)
  end

  def percent_of_calls_busy
    (calls.that_were_busy.count.to_f / calls_count * 100).round(1)
  end

  def percent_of_calls_to_voice_mail
    (calls.that_went_to_voice_mail.count.to_f / calls_count * 100).round(1)
  end

  def percent_of_calls_that_hit_a_full_mailbox
    (calls.that_hit_a_full_mailbox.count.to_f / calls_count * 100).round(1)
  end
end
