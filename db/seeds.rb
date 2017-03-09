User.create name: "admin", email: "admin@gmail.com", password: "111111",
  role: 0
(1..10).each do |i|
  User.create name: "user #{i}", email: "user_#{i}@gmail.com",
    password: "111111", role: 1
end

User.second.recipes.create name: "Cơm rang dưa bò",
  description: "Cơm rang dưa bò + hành tây",
  remote_cover_url: "http://media.phunutoday.vn/files/uplo"\
    "ad_images/2014/11/22/com-rang-dua-bo.jpg",
  duration: 20,
  status: 1

CategoryGroup.create name: "Độ khó"
CategoryGroup.create name: "Cách làm"
CategoryGroup.create name: "Mùa & lễ"
CategoryGroup.create name: "Quốc gia"
CategoryGroup.first.categories.create name: "Dễ"
CategoryGroup.first.categories.create name: "Trung bình"
CategoryGroup.first.categories.create name: "Khó"
CategoryGroup.second.categories.create name: "Luộc"
CategoryGroup.second.categories.create name: "Chiên, rán"
CategoryGroup.second.categories.create name: "xào"
CategoryGroup.second.categories.create name: "hấp"
CategoryGroup.second.categories.create name: "nướng"
CategoryGroup.find(3).categories.create name: "tết"
CategoryGroup.find(3).categories.create name: "valentine"
CategoryGroup.find(3).categories.create name: "cưới hỏi"
CategoryGroup.find(3).categories.create name: "sinh nhật"
CategoryGroup.find(4).categories.create name: "Việt Nam"
CategoryGroup.find(4).categories.create name: "Nhật Bản"
CategoryGroup.find(4).categories.create name: "Trung Quốc"
CategoryGroup.find(4).categories.create name: "Hàn Quốc"

CategoriesRecipe.create recipe: Recipe.first, category: Category.find_by(name: "Dễ")
CategoriesRecipe.create recipe: Recipe.first, category: Category.find_by(name: "Chiên, rán")
CategoriesRecipe.create recipe: Recipe.first, category: Category.find_by(name: "Việt Nam")

Recipe.first.materials.create name: "cơm"
Recipe.first.materials.create name: "trứng", number: 2, unit: "quả"
Recipe.first.materials.create name: "hành, tỏi, hạt tiêu"
Recipe.first.steps.create content: "phi hành tỏi", order: 0
Recipe.first.steps.create content: "đổ cơm vào", order: 1
Recipe.first.steps.create content: "cho trứng vào", order: 2
Recipe.first.steps.create content: "ăn", order: 3

Recipe.first.comments.create(user: User.find(2), content: "tuyệt vời ^^")
Recipe.first.comments.create(user: User.find(3), content: "ngon quá ^^")

Report.create(user: User.first, recipe: Recipe.first, content: "abc")
Report.create(user: User.second, recipe: Recipe.first, content: "123")
