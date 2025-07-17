module CommonFields
  def myId
    diver.id
  end

  def field_id=(value)
    write_attribute(:field_id, value.upcase)
  end

  def msn
    "#{msn_prefix}#{sample_date.strftime('%Y%m%d')}#{sample_begin_time.strftime('%H%M')}#{diver.diver_number}"
  end
end
