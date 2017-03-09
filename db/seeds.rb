User.create(name: "admin", email: "admin@gmail.com", password: "111111",
  role: 0)
(1..10).each do |i|
  User.create(name: "user #{i}", email: "user_#{i}@gmail.com",
    password: "111111", role: 1)
end

User.second.recipes.create(name: "Cơm rang dưa bò",
  description: "Cơm rang dưa bò + hành tây",
  cover: "http://media.phunutoday.vn/files/uplo"\
    "ad_images/2014/11/22/com-rang-dua-bo.jpg",
  duration: 20)

CategoryGroup.create(name: "Độ khó")
CategoryGroup.create(name: "Thể loại")
CategoryGroup.first.categories.create(name: "Dễ")
CategoryGroup.first.categories.create(name: "Trung bình")
CategoryGroup.first.categories.create(name: "Khó")
CategoryGroup.second.categories.create(name: "Luộc")
CategoryGroup.second.categories.create(name: "Chiên, rán")
CategoryGroup.second.categories.create(name: "xào")

CategoriesRecipe.create(recipe: Recipe.first, category: Category.first)
CategoriesRecipe.create(recipe: Recipe.first, category: Category.find_by(id: 4))

Recipe.first.materials.create(name: "cơm")
Recipe.first.materials.create(name: "trứng", number: 2, unit: "quả")
Recipe.first.materials.create(name: "hành, tỏi, hạt tiêu")
Recipe.first.steps.create(content: "phi hành tỏi", order: 0)
Recipe.first.steps.create(content: "đổ cơm vào", order: 1)
Recipe.first.steps.create(content: "cho trứng vào", order: 2)
Recipe.first.steps.create(content: "ăn", order: 3)

Recipe.first.comments.create(user: User.find(2), content: "tuyệt vời ^^")
Recipe.first.comments.create(user: User.find(3), content: "ngon quá ^^")
