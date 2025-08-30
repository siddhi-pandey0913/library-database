USE LibraryDB;

CREATE TABLE Books (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    membershipType ENUM('Regular', 'Student') NOT NULL
);
CREATE TABLE Transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE,
    status ENUM('Issued', 'Returned') DEFAULT 'Issued',
    
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (book_id) REFERENCES Books(id)
);

-- top 3 most issued books 
SELECT 
    b.id,
    b.title,
    COUNT(t.id) AS total_issues
FROM Transactions t
JOIN Books b ON t.book_id = b.id
GROUP BY b.id, b.title
ORDER BY total_issues DESC
LIMIT 3;

-- Find the user who haven't issued any book
SELECT u.id, u.name, u.email, u.membershipType
FROM Users u
LEFT JOIN Transactions t ON u.id = t.user_id
WHERE t.user_id IS NULL;

-- total books issued per user
SELECT 
    u.id,
    u.name,
    COUNT(t.id) AS total_books_issued
FROM Users u
LEFT JOIN Transactions t ON u.id = t.user_id
GROUP BY u.id, u.name;

-- books not returned yet 
SELECT 
    t.id AS transaction_id,
    b.id AS book_id,
    b.title,
    u.name AS issued_to,
    t.issue_date
FROM Transactions t
JOIN Books b ON t.book_id = b.id
JOIN Users u ON t.user_id = u.id
WHERE t.status = 'Issued';

-- most active users based on transaction count
SELECT 
    u.id,
    u.name,
    COUNT(t.id) AS total_transactions
FROM Users u
JOIN Transactions t ON u.id = t.user_id
GROUP BY u.id, u.name
ORDER BY total_transactions DESC;