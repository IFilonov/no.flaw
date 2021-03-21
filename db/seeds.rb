Staff.create!(email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
female = Female.create!(username: 'female', nickname: 'female_nickname', password: 'password',
                        password_confirmation: 'password', level: Task.levels.values[0])
male = Male.create!(username: 'male', nickname: 'male_nickname', password: 'password',
                    password_confirmation: 'password', female: female, level: Task.levels.values[0])
Pair.create!(male: male, female: female)
Task.genders.keys.size.times do |gender|
  Task.levels.keys.size.times do |level|
    10.times do |index|
      Task.create!(name: "Task#{index}", description: "about task#{index}",
                   level: Task.levels.values[level], gender: Task.genders.values[gender])
    end
  end
end
