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
