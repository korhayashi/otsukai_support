30.times do |n|
  email = Faker::Internet.email
  password = Faker::Internet.password
  category = rand(0..1)
  family_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  postal_code = Faker::Address.postcode
  address = Faker::Address.full_address
  phone_number = Faker::PhoneNumber.cell_phone

  User.create!(
    email: email,
    password: password,
    category: category,
    family_name: family_name,
    first_name: first_name,
    postal_code: postal_code,
    address: address,
    phone_number: phone_number
  )
end

30.times do |n|
  content = Faker::Food.description
  note = rand(0..1) == 1 ? Faker::String.random : ''
  status = rand(0..2)
  deadline = Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 31)
  customer_id = User.where(category: 0).pluck(:id).sample
  courier_id = (status == 1 || status == 2) ? User.where(category: 1).pluck(:id).sample : nil
  completed_date = status == 2 ? Faker::Time.between(from: DateTime.now - 31, to: DateTime.now) : nil

  Order.create!(
    content: content,
    note: note,
    status: status,
    deadline: deadline,
    customer_id: customer_id,
    courier_id: courier_id,
    completed_date: completed_date
  )
end
