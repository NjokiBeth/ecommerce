use ecommerce;
-- brand
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

INSERT INTO brand (name, description) VALUES
('Nike', 'Sportswear and sneakers'),
('Samsung', 'Electronics and gadgets');

--  product_category
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

INSERT INTO product_category (name, description) VALUES
('Clothing', 'Wearable fashion items'),
('Electronics', 'Gadgets and devices');

--  product
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

INSERT INTO product (name, description, brand_id, category_id, base_price) VALUES
('Running Shoes', 'Comfortable running shoes for daily use', 1, 1, 79.99),
('Smartphone', 'Latest model smartphone with 5G', 2, 2, 699.00);

--  color
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7)
);

INSERT INTO color (name, hex_code) VALUES
('Red', '#FF0000'),
('Black', '#000000');

-- 5. size_category
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO size_category (name) VALUES
('Clothing Sizes'),
('Shoe Sizes');

--  size_option
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT,
    name VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

INSERT INTO size_option (size_category_id, name) VALUES
(1, 'M'),
(2, '42');

--  product_item
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    color_id INT,
    size_option_id INT,
    SKU VARCHAR(100) UNIQUE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

INSERT INTO product_item (product_id, color_id, size_option_id, SKU, price, stock_quantity) VALUES
(1, 2, 2, 'NIKE-RUN-BLK-42', 89.99, 10),
(2, 1, NULL, 'SAMS-5G-RED', 749.00, 5);

--  product_image
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    image_url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    FOREIGN KEY (item_id) REFERENCES product_item(item_id)
);

INSERT INTO product_image (item_id, image_url, alt_text) VALUES
(1, 'https://example.com/images/nike-shoes-black.jpg', 'Black Nike Running Shoes'),
(2, 'https://example.com/images/samsung-red.jpg', 'Red Samsung Smartphone');

--  attribute_category
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO attribute_category (name) VALUES
('Physical'),
('Technical');

--  attribute_type
CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

INSERT INTO attribute_type (name) VALUES
('text'),
('number'),
('boolean');

--  product_attribute
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    value TEXT,
    attribute_type_id INT,
    attribute_category_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id)
);

INSERT INTO product_attribute (product_id, name, value, attribute_type_id, attribute_category_id) VALUES
(1, 'Material', 'Mesh', 1, 1),
(2, 'Battery Life', '24', 2, 2);

--  product_variation
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

INSERT INTO product_variation (product_id, color_id, size_option_id) VALUES
(1, 2, 2),
(2, 1, NULL);
