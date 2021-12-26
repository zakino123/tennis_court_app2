FactoryBot.define do
  factory :court do
    trait :court1 do
      id { 1 }
      name { '黒浜公園テニスコート' }
      address { '蓮田市大字黒浜4088番地2' }
      latitude { 35.99985767 }
      longitude { 139.67242364 }
      number { 5 }
      price { 200 }
      reserve { 'https://www.task-asp.net/cu/cm/pcerror.aspx?aspxerrorpath=/cu/ykr112381/app/ykr00000/ykr00001.aspx' }
      association :user
      user_id { 1 }
    end
    trait :court2 do
      id { 2 }
      name { '富士見公園' }
      address { '東京都羽村市緑ヶ丘４丁目１１' }
      latitude { 36.14409131 }
      longitude { 139.48024757 }
      number { 5 }
      price { 255 }
      reserve { 'https://www.hamura-tokyo.jp/reserve/login.aspx' }
      association :user
      user_id { 1 }
    end
  end
end