if Rails.env
  if Rails.env.development? || Rails.env.test?
    prefix = "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
  else
    prefix = "#{Rails.application.class.parent_name.downcase}_"
  end

  Tire::Model::Search.index_prefix(prefix) if prefix
end
