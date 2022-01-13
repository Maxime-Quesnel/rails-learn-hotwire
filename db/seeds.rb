5_000.times do |item|
  Employee.create(
    name: Faker::Name.name,
    position: ['Accountant', 'Chief Executive Officer (CEO)', 'Chief Financial Officer (CFO)', 'Chief Marketing Officer (CMO)', 'Software Engineer'].sample,
    office: ["London", "Singapore", "Tokyo", "New York", "Edinburgh", "San Francisco"].sample,
    age: rand(20..100),
    start_date: rand(1..1000).days.ago.to_date,
    is_active: [true, false].sample,
  )
end