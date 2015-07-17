def truncate_companies
  Company.destroy_all
end

def create_companies
  50.times do
    c = Company.create(title: Faker::Company.name, lat: 50.448853, long: 30.513346)
    create_logo(c.id)
  end
end

def truncate_users
  User.destroy_all
end

def create_categories
  5.times do |i|
    Category.create(name: "Category #{i+1}")
  end
end

def create_users
  5.times do
    u = User.create(email: Faker::Internet.email)
    create_avatar(u.id)
  end
end

def truncate_products
  Product.destroy_all
end

def create_products
  50.times do
    Faker::Config.locale = 'en'
    p = Product.new(title_en:Faker::Commerce.product_name, title_de:Faker::Commerce.product_name, title_fr:Faker::Commerce.product_name, 
                    price: Faker::Number.number(3), company: Company.all[rand(0..4)], user: User.all[rand(0..4)])
    Faker::Config.locale = 'ru'
    p.title_ru = Faker::Commerce.product_name
    p.save
    create_product_image(p.id)
  end
end

def create_product_image(id)
  b = ProductImage.new
  image = File.open(Rails.root+"public/fake_images/product.png")
  b.data = image
  b.assetable_id = id
  b.assetable_type = "Product"
  b.is_main = true
  b.save!
end

def create_avatar(id)
  b = Avatar.new
  image = File.open(Rails.root+"public/fake_images/avatar.png")
  b.data = image
  b.assetable_id = id
  b.assetable_type = "User"
  b.is_main = true
  b.save!
end

def create_logo(id)
  b = Logo.new
  image = File.open(Rails.root+"public/fake_images/logo.jpg")
  b.data = image
  b.assetable_id = id
  b.assetable_type = "Company"
  b.is_main = true
  b.save!
end

def truncate_images
  Logo.destroy_all
  Avatar.destroy_all
  ProductImage.destroy_all
end

truncate_images
truncate_companies
create_companies
truncate_users
create_users
truncate_products
create_products
create_categories