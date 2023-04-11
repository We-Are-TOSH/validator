FactoryBot.define do
  factory :identity_verification do
    id_number { "1234567890123" }
    firstnames { "John" }
    lastname { "Doe" }
    dob { Date.parse("1990-01-01") }
    gender { "Male" }
    citizenship { "South African" }
  end
end
