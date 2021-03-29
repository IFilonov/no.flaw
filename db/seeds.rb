Staff.create!(email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
female = Female.create!(username: 'female', nickname: 'female_nickname', password: 'password',
                        password_confirmation: 'password')
male = Male.create!(username: 'male', nickname: 'male_nickname', password: 'password',
                    password_confirmation: 'password', female: female)
Pair.create!(male: male, female: female, level: Pair.levels[:low])
3.times { |id| Category.create!(name: "Category #{id}") }
Task.genders.keys.size.times do |gender|
  Category.all.each do |category|
    Task.levels.keys.size.times do |level|
      20.times do |index|
        Task.create!(name: "Task#{index}", description: "about task#{index}",
                     level: Task.levels.values[level], gender: Task.genders.values[gender],
                     category: category)
      end
    end
  end
end
