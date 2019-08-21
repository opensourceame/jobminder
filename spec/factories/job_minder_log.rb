FactoryBot.define do
  factory :job_minder_log do

    name { 'Amsterdam' }
    line_1 { 'Sint Petershalsteeg 3' }
    city { 'Amsterdam' }
    province { 'Noord-Holland' }
    post_code { '1012 GL' }
    country_code { 'NL' }
    latitude { 52.3712707 }
    longditude { 4.8941912 }
  end
end
