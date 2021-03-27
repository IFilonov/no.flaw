Staff.create!(email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
female = Female.create!(username: 'female', nickname: 'female_nickname', password: 'password',
                        password_confirmation: 'password')
male = Male.create!(username: 'male', nickname: 'male_nickname', password: 'password',
                    password_confirmation: 'password', female: female)
Pair.create!(male: male, female: female, level: Pair.levels[:low])
Task.genders.keys.size.times do |gender|
  Task.levels.keys.size.times do |level|
    20.times do |index|
      Task.create!(name: "Task#{index}", description: "about task#{index}",
                   level: Task.levels.values[level], gender: Task.genders.values[gender])
    end
  end
end
