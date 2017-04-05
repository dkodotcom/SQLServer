--Q1
SELECT * 
FROM Library_Branch INNER JOIN Book_Copies
ON Library_Branch.BranchID = Book_Copies.BranchID
WHERE BranchName = 'Sharpstown'
AND BookID = 1


--Q2
SELECT * 
FROM Book AS B
INNER JOIN Book_Copies AS BC
ON B.BookID = BC.BookID 
JOIN Library_Branch	AS LB
ON BC.BranchID = LB.BranchID
WHERE B.BookID = 1


--Q3
SELECT *
FROM Borrower AS B 
LEFT OUTER JOIN Book_Loans AS BL
ON B.CardNo = BL.CardNo
WHERE BL.BookID IS NULL


--Q4
SELECT B.Title, BOR.Name, BOR.Address
FROM Book AS B
INNER JOIN Book_Loans AS BL
ON B.BookID = BL.BookID
JOIN Borrower AS BOR
ON BL.CardNo = BOR.CardNo 
WHERE BL.BranchID =  1
AND DueDate = '2017-04-02'


--Q5
SELECT COUNT(BL.BranchID) AS BooksByBranch
FROM Library_Branch AS LB
INNER JOIN Book_Loans AS BL
ON LB.BranchID = BL.BranchID
GROUP BY LB.BranchID


--Q6
SELECT B.Name, B.Address, COUNT(BL.CardNo) AS BooksCO
FROM Borrower AS B
INNER JOIN Book_Loans AS BL
ON B.CardNo = BL.CardNo 
GROUP BY B.Name, B.Address, BL.CardNo
HAVING COUNT(BL.CardNo) > 5


--Q7
SELECT B.Title, BC.No_Of_Copies, LB.BranchName
FROM Book AS B
INNER JOIN Book_Loans AS BL
ON B.BookID = BL.BookID
JOIN Book_Copies AS BC
ON BL.BranchID = BC.BranchID
JOIN Library_Branch AS LB
ON BC.BranchID = LB.BranchID
WHERE BC.BranchID = 2
AND B.Author = 'Stephen King'


--Procedure
CREATE PROC GetBooksByBranchID @ID VARCHAR(50)
AS 
	SELECT LB.BranchName, LB.Address, BL.CardNo
	FROM
	Library_Branch AS LB 
	INNER JOIN Book_Loans AS BL
	ON LB.BranchID = BL.BranchID
	WHERE LB.BranchID = @ID