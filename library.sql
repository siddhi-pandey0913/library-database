USE LibraryDB;
CREATE TABLE Books (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    available BOOLEAN DEFAULT TRUE
);
INSERT INTO Books (id, title, author, available)
VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', TRUE),
(2, 'To Kill a Mockingbird', 'Harper Lee', TRUE),
(3, '1984', 'George Orwell', TRUE),
(4, 'Pride and Prejudice', 'Jane Austen', TRUE);
SELECT * FROM Books;