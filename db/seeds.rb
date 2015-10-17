User.create(email: 'hoge@example.com', password: 'password')

10.times do |i|
  Result.create(name: Gimei.kanji, score: rand(0..60), adult: true)
  Result.create(name: Gimei.first.hiragana, score: rand(0..60), adult: false)
end
