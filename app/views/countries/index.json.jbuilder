json.array!(@countries) do |country|
  json.extract! country, :id, :name, :population, :median_age, :life_expectancy, :gdp, :mandatory_military_service
  json.url country_url(country, format: :json)
end
