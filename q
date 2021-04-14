[1mdiff --git a/app/patterns/presenters/pair_info_presentor.rb b/app/patterns/presenters/pair_info_presentor.rb[m
[1mindex f722c0e..265a622 100644[m
[1m--- a/app/patterns/presenters/pair_info_presentor.rb[m
[1m+++ b/app/patterns/presenters/pair_info_presentor.rb[m
[36m@@ -5,9 +5,9 @@[m [mclass PairInfoPresentor[m
   end[m
 [m
   def info[m
[31m-    { me: @user.as_json(only: %i[id username]),[m
[32m+[m[32m    { me: @user.as_json(only: %i[id username nickname]),[m
       pair: { username: @pair&.username, nickname: @pair&.nickname,[m
               pair_created_at: @pair&.created_at,[m
[31m-              id: @pair&.id } }[m
[32m+[m[32m              id: @pair&.id } }.with_indifferent_access[m
   end[m
 end[m
[1mdiff --git a/spec/models/male_spec.rb b/spec/models/male_spec.rb[m
[1mindex 5ca6b64..eb1596d 100644[m
[1m--- a/spec/models/male_spec.rb[m
[1m+++ b/spec/models/male_spec.rb[m
[36m@@ -34,5 +34,14 @@[m [mRSpec.describe Male, type: :model do[m
       expect(male.female.username).to eq female.username[m
       expect(male.pairs.last.female.id).to eq female.id[m
     end[m
[32m+[m
[32m+[m[32m    it 'show info' do[m
[32m+[m[32m      info = male.info[m
[32m+[m[32m      expect(info[:me][:username]).to eq male.username[m
[32m+[m[32m      expect(info[:me][:nickname]).to eq male.nickname[m
[32m+[m
[32m+[m[32m      expect(info[:pair][:username]).to eq female.username[m
[32m+[m[32m      expect(info[:pair][:nickname]).to eq female.nickname[m
[32m+[m[32m    end[m
   end[m
 end[m
