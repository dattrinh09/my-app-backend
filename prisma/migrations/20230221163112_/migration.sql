-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "is_admin" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "brands" (
    "id" SERIAL NOT NULL,
    "brand_name" TEXT NOT NULL,

    CONSTRAINT "brands_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" SERIAL NOT NULL,
    "product_name" TEXT NOT NULL,
    "description" TEXT,
    "price" DOUBLE PRECISION NOT NULL,
    "in_stock" INTEGER NOT NULL,
    "brand_id" INTEGER NOT NULL,
    "url" TEXT NOT NULL,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "phone_number" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "order_time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "total" DOUBLE PRECISION NOT NULL,
    "status" INTEGER NOT NULL DEFAULT 0,
    "product_id" INTEGER NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "brands_brand_name_key" ON "brands"("brand_name");

-- CreateIndex
CREATE UNIQUE INDEX "products_brand_id_product_name_key" ON "products"("brand_id", "product_name");

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "brands"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Insert into users
INSERT INTO "users"(username, email, password, is_admin)
VALUES
('admin', 'admin@gmail.com', '$2b$10$eBhhHLKZybL.Bb4ZZvu1I.IFKe338sY7LENIz.P9iU3wQWIxjm.om', true),
('dat', 'dat@gmail.com', '$2b$10$Wpc8weQNvB2wHkvOhZwm4.gU.QA9faG6wx4UyehMgfbuvonbA0liu', false),
('hieu', 'hieu@gmail.com', '$2b$10$rvA9680CCnQYwf/T.K7cW.x/xaI7HNhYLAJxBsjcW9bZdQcemID5a', false),
('anh', 'anh@gmail.com', '$2b$10$60XrT6WqoGZjI9aBLZQu7eY9fr2jjjv8Fveofh9jh1SvJOORbDeau', false),
('hai', 'hai@gmail.com', '$2b$10$LSC9E9Q3hVK3SHOG/ewRG./g7Yn1VTpUWbHWAKTp4H3J.9i3J2RSW', false),
('hung', 'hung@gmail.com', '$2b$10$iz7E.2HPjZCptWhPniZCmuLzrvhsFLleuBBy.4x/JbxTRJBg./JUu', false),
('dung', 'dung@gmail.com', '$2b$10$epuqD59QgpU2oiFA.j30Tu4SfHWMMszluiyyTVjuQUzDrCns/ckgy', false),
('du', 'du@gmail.com', '$2b$10$mnyE/8QPUUvHuL.dzggv9eW1yjC3Gtx8qskXWqpFBZa36O8f97fse', false),
('bao', 'bao@gmail.com', '$2b$10$X44W5ozrJ/QtvUwvv7zxxe6qh.LBJKu7gjOzM4PhQjJ5n7BvFa9Na', false),
('nghia', 'nghia@gmail.com', '$2b$10$AunmPg0UWilcSx/CD4RL2eykkS.fIxIoa9qdxen3qUp7/YlkF7bZy', false),
('tan', 'tan@gmail.com', '$2b$10$KZXRSUlvh0PIGSfzLI5PHesUGdLfmeQDnM0/QXyN9psJvmvXImVZS', false);

-- Insert into brands
INSERT INTO "brands"(brand_name)
VALUES
('Apple'),
('Samsung'),
('Xiaomi'),
('Realme'),
('OPPO'),
('Vivo'),
('Asus'),
('Masstel'),
('Nokia'),
('Tecno');

-- Insert into products
INSERT INTO "products"(product_name, description, brand_id, price, in_stock, url)
VALUES 
('iPhone 12 64GB','AMOLED FHD+',1,15499000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/12/6/638059237853240136_iphone-12-xanhla-1.jpg'),
('Xiaomi Redmi 10 4GB 128GB 2021','AMOLED FHD+',3,3790000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/8/19/637649622568371405_xiaomi-redmi-10-trang-1.jpg'),
('Xiaomi Redmi Note 11 4GB 128GB','AMOLED FHD+',3,4190000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/1/27/637788719726788724_xiaomi-redmi-note-11-xanh-1.jpg'),
('OPPO A77s 8GB 128GB','AMOLED FHD+',5,5990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/10/5/638005897366049263_oppo-a77s-den-5.jpg'),
('iPhone 11 64GB','AMOLED FHD+',1,11299000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/12/6/638059309890101717_iphone-11-trang-1.jpg'),
('Xiaomi Redmi 10A 3GB 64GB','AMOLED FHD+',3,2790000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/12/21/638072287030090738_Xiaomi-Redmi-10A-2GB-32GB-xanh-1.jpg'),
('OPPO A95 8GB 128GB','AMOLED FHD+',5,5990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/11/20/637730059696400830_oppo-a95-bac-1.jpg'),
('Oppo Reno6 5G','AMOLED FHD+',5,8990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/7/21/637624918161746288_oppo-reno6-den-1.jpg'),
('Samsung Galaxy A04','AMOLED FHD+',2,2590000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/10/11/638011085204016717_samsung-galaxy-a04-den-3.jpg'),
('OPPO A17k 3GB 64GB','AMOLED FHD+',5,3290000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/11/2/638029862729276175_oppo-a17k-xanh-4.jpg'),
('Samsung Galaxy A13','AMOLED FHD+',2,4190000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/3/21/637834691340604790_samsung-galaxy-a13-den-1.jpg'),
('Vivo T1x 4GB 64GB','AMOLED FHD+',6,4190000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/7/21/637939995440901432_vivo-t1x-xanh-1.jpg'),
('OPPO A57 4GB 128GB','AMOLED FHD+',5,4390000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/6/27/637919437068621162_oppo-a57-den-3.jpg'),
('Samsung Galaxy A53 5G 256GB','AMOLED FHD+',2,8990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/3/10/637825310288115049_samsung-galaxy-a53-den-4.jpg'),
('Realme C30s 2GB 32GB','AMOLED FHD+',4,2390000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/16/637989169500528282_realme-c30s-xanh-5.jpg'),
('Realme C35 4GB 128GB','AMOLED FHD+',4,4590000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/4/12/637853607399530098_realme-c35-den-1.jpg'),
('Samsung Galaxy A04s','AMOLED FHD+',2,3590000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/14/637987530648955323_samsung-galaxy-a04s-den-4.jpg'),
('Xiaomi Redmi 10C 4GB 128GB','AMOLED FHD+',3,3490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/3/16/637830415222601150_xiaomi-redmi-10c-4gb-128gb-xanh-1.jpg'),
('Xiaomi 11T Pro 5G 12GB 256GB','AMOLED FHD+',3,11790000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/10/7/637692066784791588_xiaomi-11t-pro-xam-1.jpg'),
('Vivo Y33s 8GB 128GB','AMOLED FHD+',6,5990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/3/15/637829406490980283_vivo-y33s-vang-1.jpg'),
('OPPO Reno8 Z 5G 8GB 256GB','AMOLED FHD+',5,9190000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/8/5/637952922019455368_oppo-reno8-z-vang-4.jpg'),
('Samsung Galaxy Z Flip4 5G 128GB','AMOLED FHD+',2,18990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/8/10/637957658354316100_samsung-galaxy-z-flip4-tim-1.jpg'),
('Samsung Galaxy Z Fold4 5G 256GB','AMOLED FHD+',2,35990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/8/10/637957717267975494_samsung-galaxy-z-fold4-xanh-1.jpg'),
('Vivo Y16 4GB 128GB','AMOLED FHD+',6,4190000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/9/637983383787837357_vivo-y16-vang-6.jpg'),
('Vivo Y15s 3GB 32GB','AMOLED FHD+',6,2790000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/10/25/637707822857276078_00779950-vivo-y15s-trang-xanh-1.jpg'),
('Vivo Y22s 8GB 128GB','AMOLED FHD+',6,5690000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/9/637983398316214932_vivo-y22s-xanh-7.jpg'),
('Vivo Y35 8GB 128GB','AMOLED FHD+',6,6590000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/10/18/638016883147092027_vivo-y35-vang-3.jpg'),
('Asus ROG 6 DIABLO 16GB 512GB','AMOLED FHD+',7,26990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/12/8/638061192535395457_asus-rog6-diablo-5.jpg'),
('iPhone 13 Pro Max 256GB','AMOLED FHD+',1,29490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/4/19/637859778843241685_iphone-13-pro-max-vang-1.jpg'),
('iPhone 14 Pro Max 128GB','AMOLED FHD+',1,29490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/11/30/638054220350691584_ip-14-pro-max-tim-1.jpg'),
('Samsung Galaxy A03','AMOLED FHD+',2,2190000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/1/5/637770017035736391_samsung-galaxy-a03-do-1.jpg'),
('OPPO A16 3GB 32GB','AMOLED FHD+',5,3490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/2/26/637814717692035087_oppo-a16-bac-1.jpg'),
('Xiaomi Redmi 10 2022 4GB 128GB','AMOLED FHD+',3,3790000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/5/10/637877742594774669_xiaomi-redmi-10-2022-xam-1.jpg'),
('OPPO A76 6GB 128GB','AMOLED FHD+',5,5490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/2/26/637814711773704753_oppo-a76-den-1.jpg'),
('Samsung Galaxy A23','AMOLED FHD+',2,5690000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/3/21/637834656039848616_samsung-galaxy-a23-den-1.jpg'),
('iPhone 14 128GB','AMOLED FHD+',1,19990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/11/30/638054088819837718_ip-14-do-1.jpg'),
('Samsung Galaxy S22 Plus 5G 128GB','AMOLED FHD+',2,20990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/2/10/637800486734376188_samsung-galaxy-s22-plus-den-1.jpg'),
('iPhone 14 Plus 128GB','AMOLED FHD+',1,22990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/11/30/638054166106341023_ip-14-plus-do-1.jpg'),
('Samsung Galaxy S22 Ultra 5G 128GB','AMOLED FHD+',2,23990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/2/9/637800453115752334_samsung-galaxy-s22-ultra-den-1.jpg'),
('OPPO Find X5 Pro 12GB 256GB','AMOLED FHD+',5,24990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/8/637982295035080684_oppo-find-x5-pro-trang-5.jpg'),
('Asus ROG 6 BATMAN 12GB 256GB','AMOLED FHD+',7,24990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/12/8/638061190099372111_asus-rog6-batman-den-5.jpg'),
('Samsung Galaxy Z Fold3 5G 512GB','AMOLED FHD+',2,26490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/8/11/637643199945549459_samsung-galaxy-z-fold3-bac-1.jpg'),
('iPhone 14 Pro 128GB','AMOLED FHD+',1,26990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/11/30/638054213959247730_ip-14-pro-tim-1.jpg'),
('Vivo V25 5G 8GB 128GB','AMOLED FHD+',6,9990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/14/637987658871975174_vivo-v25e-den-1.jpg'),
('Samsung Galaxy A73 5G','AMOLED FHD+',2,11990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/4/7/637849355333862203_samsung-galaxy-a73-xam-1.jpg'),
('Vivo V25 Pro 5G 8GB 128GB','AMOLED FHD+',6,13490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/11/10/638036697912732913_vivo-v25-pro-5g-den-5.jpg'),
('Xiaomi 12T Pro 12GB 256GB','AMOLED FHD+',3,16490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/10/1/638002201874658273_xiaomi-12t-pro-den-5.jpg'),
('Samsung Galaxy S22 5G 128GB','AMOLED FHD+',2,16990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/2/10/637800498484893706_samsung-galaxy-s22-den-12.jpg'),
('OPPO Reno8 Pro 5G 12GB 256GB','AMOLED FHD+',5,17290000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/22/637994545333519337_oppo-reno8-pro-den-5.jpg'),
('iPhone 13 128GB','AMOLED FHD+',1,18490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/4/25/637864948054568276_iphone-13-hong-1.jpg'),
('ASUS ROG Phone 6 12GB 256GB','AMOLED FHD+',7,19990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/7/26/637944496334053194_asus-rog-6-12gb-256gb-trang-3.jpg'),
('Masstel Izi 10 4G','AMOLED FHD+',8,530000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/12/8/637745788503092505_masstel-izi-10-4g-xanh-1.jpg'),
('Masstel Izi 20 4G','AMOLED FHD+',8,580000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/12/12/638064543219912989_masstel-izi-20-4g-xanh-3.jpg'),
('Masstel Izi 25 4G','AMOLED FHD+',8,650000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/8/25/637970331056102648_masstel-izi-25-den-4.jpg'),
('Masstel Izi 55 4G','AMOLED FHD+',8,700000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/12/8/637745812596615938_masstel-izi-55-4g-xanh-1.jpg'),
('Masstel Lux 10 4G','AMOLED FHD+',8,750000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/14/637987480211745480_masstel-lux-10-vang-5.jpg'),
('Masstel Lux 20 4G','AMOLED FHD+',8,850000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/8/9/637956505093585918_masstel-lux-20-xanh-5.jpg'),
('Masstel Fami 65 4G','AMOLED FHD+',8,900000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/7/637981664253530377_masstel-fami-65-vang-5.jpg'),
('Xiaomi Redmi A1 2GB 32GB','AMOLED FHD+',3,1990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/30/638001571506654078_xiaomi-redmi-a1-den-5.jpg'),
('Masstel Hapi 30 4G','AMOLED FHD+',8,1690000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/12/15/637751862125555591_masstel-hapi-30-4g-den-1.jpg'),
('Xiaomi Redmi 9A 2GB 32GB','AMOLED FHD+',3,1990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2020/7/6/637296419754096912_xiaomi-redmi-9a-xanh-1.png'),
('Samsung Galaxy S22 Bora Purple 5G','AMOLED FHD+',2,14990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/7/23/637941779749495327_samsung-galaxy-s22-bora-purple-1.jpg'),
('Xiaomi Redmi Note 11 Pro 8GB 128GB','AMOLED FHD+',3,6590000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/2/14/637804673210218283_2.xiaomi-redmi-note-11-pro-4g-xam-4.jpg'),
('Nokia C20 2GB 32GB','AMOLED FHD+',9,2290000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/4/16/637541853655217577_nokia-c20-xanh-1.jpg'),
('Nokia C31 3GB 32GB','AMOLED FHD+',9,2490000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/10/4/638004810271170395_nokia-c31-xanh-la-5.jpg'),
('Nokia G11 Plus 3GB 32GB','AMOLED FHD+',9,2590000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/8/2/637950481044337237_nokia-g11-plus-xanh-1.jpg'),
('Nokia 5710 XpressAudio','AMOLED FHD+',9,1790000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/10/18/638016911095524490_nokia-5710-xpressaudio-trang-4.jpg'),
('Nokia G21 6GB 128GB','AMOLED FHD+',9,3990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/3/21/637834867146141050_nokia-g21-tim-1.jpg'),
('Nokia C30 3GB 32GB','AMOLED FHD+',9,2290000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/8/18/637649100605269420_nokia-c30-xanh-1.jpg'),
('TECNO SPARK 7 2GB 32GB','AMOLED FHD+',10,2390000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/10/22/637705100743690648_Spark7-xanh-la-0.jpg'),
('TECNO POP 5 2GB 32GB','AMOLED FHD+',10,2190000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/4/13/637854623685245274_tecno-pop-5-xanhdam-1.jpg'),
('Nokia 110 DS 4G','AMOLED FHD+',9,870000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2021/7/1/637607591141873936_nokia-110-4g-den-1.jpg'),
('Nokia 215 DS 4G','AMOLED FHD+',9,990000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2020/11/13/637408828200221858_nokia-215-den-1.png'),
('Nokia 2660 Flip 4G','AMOLED FHD+',9,1590000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/9/15/637988559501334883_nokia-2660-flip-den-2.jpg'),
('Nokia 8210 4G','AMOLED FHD+',9,1590000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/8/4/637952294132626253_nokia-8210-4g-xanh-5.jpg'),
('Nokia C21 Plus 3GB 32GB','AMOLED FHD+',9,2290000,10,'https://images.fpt.shop/unsafe/fit-in/800x800/filters:quality(90):fill(white):upscale()/fptshop.com.vn/Uploads/Originals/2022/5/6/637874572200629275_nokia-c21-plus-xanh-1.jpg');

-- Insert into orders
INSERT INTO "orders"(user_id, phone_number, address, total, status, product_id)
VALUES
(2,'0123456789','325 kim nguu',3790000,0,2),
(2,'0123456789','325 kim nguu',4190000,0,3),
(2,'0123456789','325 kim nguu',5990000,0,4),
(2,'0123456789','325 kim nguu',11299000,0,5),
(2,'0123456789','325 kim nguu',2790000,0,6),
(3,'0123456789','15 nhon',5990000,0,7),
(3,'0123456789','15 nhon',8990000,0,8),
(3,'0123456789','15 nhon',2590000,0,9),
(3,'0123456789','15 nhon',3290000,0,10),
(3,'0123456789','15 nhon',4190000,0,11),
(4,'0123456789','10 nguyen trai',4190000,0,12),
(4,'0123456789','10 nguyen trai',4390000,0,13),
(4,'0123456789','10 nguyen trai',8990000,0,14),
(4,'0123456789','10 nguyen trai',2390000,0,15),
(4,'0123456789','10 nguyen trai',4590000,0,16),
(5,'0123456789','155 hoai duc',3590000,0,17),
(5,'0123456789','155 hoai duc',3490000,0,18),
(5,'0123456789','155 hoai duc',11790000,0,19),
(5,'0123456789','155 hoai duc',5990000,0,20),
(5,'0123456789','155 hoai duc',9190000,0,21),
(6,'0123456789','165 cau giay',18990000,0,22),
(6,'0123456789','165 cau giay',35990000,0,23),
(6,'0123456789','165 cau giay',4190000,0,24),
(6,'0123456789','165 cau giay',2790000,0,25),
(6,'0123456789','165 cau giay',5690000,0,26);
