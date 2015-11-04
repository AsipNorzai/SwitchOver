CREATE TABLE users
(
  id SERIAL4 PRIMARY KEY,
  firstName VARCHAR(100) NOT NULL,
  lastName VARCHAR(100) NOT NULL,
  mobile VARCHAR(50),
  email VARCHAR(100) NOT NULL,
  password_digest VARCHAR(100) NOT NULL,
  address VARCHAR(200),
  postcode INTEGER,
  suburb VARCHAR(100),
  state VARCHAR(100),
  image VARCHAR(500),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
--
-- INSERT INTO users (firstName, lastName, mobile, email, password, address, postcode, suburb, state, image) VALUES ('Naimat', 'Noorzai', 0402792236, 'naimatnorzai@gmail.com', 'naimat123', '11 Sutherland Road', 3175, 'Dandenong', 'Victoria', 'https://s3.amazonaws.com/foodspotting-ec2/reviews/5622826/thumb_600.jpg?1445753652?1445831241');


-- ALTER TABLE users ADD posts_id INTEGER;
ALTER TABLE posts ADD user_id INTEGER;
ALTER TABLE posts ADD user_email VARCHAR(100);


CREATE TABLE posts
(
  id SERIAL4 PRIMARY KEY,
  categories VARCHAR(100) NOT NULL,
  heading VARCHAR(200) NOT NULL,
  want VARCHAR(100),
  give VARCHAR(100),
  body VARCHAR(500) NOT NULL,
  image VARCHAR(500),
  avaliablity VARCHAR(100),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- INSERT INTO users (categories, heading, learn, teach, body, image, avaliablity) VALUES ('Music', 'Anayone avaliablity for guitar teaching?', 'Learn Guitar', 'Teach Piano' 'Hey I wan to learn Guitar and am from Dandenong. So anyone that want\'s to learn Piono can teach me guitar in return', 'http://maton.com.au/assets/images/acoustic_product_MINID_2.jpg');
