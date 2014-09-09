seed_dir = Rails.root.join('db', 'seeds')
Dir.glob(seed_dir.join("*.rb")).each do |f|
  require f
end

