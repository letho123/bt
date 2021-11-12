--Nguyễn Thanh Sang - 20118191
--C3(10-12)
BÀI TẬP 3: LỆNH SELECT – TRUY VẤN GOM NHÓM
/*1. Danh sách các orders ứng với tổng tiền của từng hóa đơn. Thông tin bao gồm
OrdersId, OrderDate, TotalAccount. Trong đó TotalAccount là Sum của
Quantity * Unitprice, kết nhóm theo OrderId.*/
SELECT OD.OrderId, OrderDate, TotalAccount = Sum(Quantity * Unitprice)
FROM [dbo].[Order Details] OD JOIN [dbo].[Orders] O ON OD.OrderID=O.OrderID
GROUP BY OD.OrderId, OrderDate
2. Danh sách các orders ứng với tổng tiền của từng hóa đơn được lập ở thành phố
(Shipcity) là ‘Madrid’. Thông tin bao gồm OrdersId, OrderDate, TotalAccount.
Trong đó TotalAccount là Sum của Quantity * Unitprice, kết nhóm theo
OrderId.
SELECT OD.OrderId, OrderDate, TotalAccount = Sum(Quantity * Unitprice)
FROM [dbo].[Order Details] OD JOIN [dbo].[Orders] O ON OD.OrderID=O.OrderID
WHERE [ShipCity] = 'MADRID'
GROUP BY OD.OrderId, OrderDate
3. Danh sách các Products có tổng số lượng lập hóa đơn lớn nhất. Thông tin gồm
ProductID, ProductName, CountOfOrders.
SELECT TOP 1 WITH TIES OD.[ProductID],[ProductName],CountOfOrders = COUNT(OD.[ProductID])
from [dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID=P.ProductID
GROUP BY OD.[ProductID],[ProductName]
ORDER BY COUNT(OD.[ProductID]) DESC
4. Cho biết mỗi customers đã lập bao nhiêu hóa đơn. Thông tin gồm CustomerID,
CompanyName, CountOfOrder. Trong đó CountOfOrder (tổng số hóa đơn)
được đếm (Count) theo từng Customers.
SELECT O.[CustomerID],[CompanyName], CountOfOrder = COUNT(O.[CustomerID])
FROM [dbo].[Customers] C JOIN [dbo].[Orders] O ON C.CustomerID=O.CustomerID
GROUP BY O.[CustomerID],[CompanyName]
5. Cho biết mỗi Employee đã lập được bao nhiêu hóa đơn, ứng với tổng tiền.
SELECT o.[EmployeeID],FULLNAME = [LastName]+' '+[FirstName],CountOfOrder = count(o.[OrderID]), TotalAccount = Sum(Quantity * Unitprice)
from [dbo].[Employees] E join [dbo].[Orders] O on E.EmployeeID = O.EmployeeID
join [dbo].[Order Details] OD on od.OrderID = o.OrderID
group by  o.[EmployeeID],[LastName]+' '+[FirstName]
6. Liệt kê bảng lương của mỗi nhân viên theo từng tháng trong năm 1996 gồm
EmployeeID, EmployName, Month_Salary, Salary =
sum(quantity*unitprice)*10%. Được sắp xếp theo Month_Salary, cùmg
Month_Salary thì sắp xếp theo Salary giảm dần.
select O.[EmployeeID],EmployName=[LastName]+' '+[FirstName],Month_Salary = MONTH([OrderDate]), Salary = sum([UnitPrice]*[Quantity])*10/100
from [dbo].[Employees] E join [dbo].[Orders] O on E.EmployeeID=O.EmployeeID
join [dbo].[Order Details] OD on OD.OrderID=O.OrderID
group by O.[EmployeeID],[LastName]+' '+[FirstName],MONTH([OrderDate])
order by MONTH([OrderDate]),Salary
7. Danh sách các customer ứng với tổng tiền các hoá đơn, mà các hóa đơn được
lập từ 31/12/1996 đến 1/1/1998 và tổng tiền các hóa đơn >20000.
set dateformat dmy
select O.[CustomerID],[CompanyName],TotalAccount=sum([UnitPrice]*[Quantity])
from [dbo].[Customers] C join [dbo].[Orders] O on C.CustomerID=O.CustomerID
join [dbo].[Order Details] OD on OD.OrderID = O.OrderID
where [OrderDate] between '31/12/1996' AND '1/1/1998'
group by O.[CustomerID],[CompanyName]
having sum([UnitPrice]*[Quantity])> 20000

8. Danh sách các customer ứng với tổng số hoá đơn, tổng tiền các hoá đơn, mà
các hóa đơn được lập từ 31/12/1996 đến 1/1/1998 và tổng tiền các hóa đơn
>20000. Thông tin được sắp xếp theo CustomerID, cùng mã thì sắp xếp theo
tổng tiền giảm dần.
select O.[CustomerID],[CompanyName],TotalAccount=sum([UnitPrice]*[Quantity])
from [dbo].[Customers] C join [dbo].[Orders] O on C.CustomerID=O.CustomerID
join [dbo].[Order Details] OD on OD.OrderID = O.OrderID
where [OrderDate] between '31/12/1996' AND '1/1/1998'
group by O.[CustomerID],[CompanyName]
having sum([UnitPrice]*[Quantity])> 20000
order by O.[CustomerID],sum([UnitPrice]*[Quantity])
9. Danh sách các Category có tổng số lượng tồn (UnitsInStock) lớn hơn 300, đơn
giá trung bình nhỏ hơn 25. Thông tin kết quả bao gồm CategoryID,
CategoryName, Total_UnitsInStock, Average_Unitprice.
select C.[CategoryID],[CategoryName],Total_UnitsInStock=SUM([UnitsInStock]),Average_Unitprice = AVG([UnitPrice])
from [dbo].[Products] P join [dbo].[Categories] C on P.[CategoryID] = C.[CategoryID]
group by C.[CategoryID],[CategoryName]
having SUM([UnitsInStock]) > 300 and  AVG([UnitPrice])<25
10. Danh sách các loại sản phẩm (Category) có tổng số sản phẩm (product) nhỏ
hớn 10. Thông tin kết quả bao gồm CategoryID, CategoryName,
TotalOfProducts. Được sắp xếp theo CategoryName, cùng tên loại theo
TotalOfProducts giảm dần.
select C.[CategoryID],[CategoryName],TotalOfProducts = count([ProductID])
from [dbo].[Products] P join [dbo].[Categories] C on P.[CategoryID] = C.[CategoryID]
group by C.[CategoryID],[CategoryName]
having count([ProductID])<10 
order by CategoryName,count([ProductID])
11. Liệt kê danh sách các sản phẩm bán trong quý 1 năm 1998 có tổng số lương
>200, thông tin gồm [ProductID], [ProductName], SumofQuatity
Select OD.[ProductID],[ProductName],SumofQuantity=sum(OD.[ProductID])
from [dbo].[Products] P join [dbo].[Order Details] OD on P.ProductID=OD.ProductID
join [dbo].[Orders] O on O.OrderID=OD.OrderID
where DATEPART(QQ,[OrderDate]) =1 AND year([OrderDate])=1998
group by OD.[ProductID],[ProductName]
12. Danh sách các Customer ứng với tổng tiền của các hóa đơn ở từng tháng.
Thông tin bao gồm CustomerID, CompanyName, Month_Year, Total. Trong
đó Month_year là tháng và năm lập hóa đơn, Total là tổng của Unitprice*
Quantity.
select O.CustomerID, CompanyName, MonthOder=MONTH([OrderDate]), YearOder = Year([OrderDate]),Total = sum(Unitprice*Quantity)
from [dbo].[Customers] C join [dbo].[Orders] O on C.CustomerID=O.CustomerID
join [dbo].[Order Details] OD on O.OrderID=OD.OrderID
group by O.CustomerID, CompanyName,MONTH([OrderDate]),Year([OrderDate])
13. Cho biết Employees nào bán được nhiều tiền nhất trong 7 của năm 1997
select top 1 with ties O.[EmployeeID], FullName = [LastName]+' '+[FirstName],ToTalAccount = sum([UnitPrice]*[Quantity])
from [dbo].[Employees] E join [dbo].[Orders] O on E.EmployeeID=O.EmployeeID
join [dbo].[Order Details] OD on O.OrderID = OD.OrderID
group by  O.[EmployeeID],[LastName]+' '+[FirstName]
order by sum([UnitPrice]*[Quantity]) desc
14. Danh sách 3 khách có nhiều đơn hàng nhất của năm 1996.
select top 3 with ties O.[CustomerID],[CompanyName], SLDONHANG = count([OrderID])
from [dbo].[Customers] C join [dbo].[Orders] O on O.CustomerID=C.CustomerID
group by O.[CustomerID],[CompanyName]
order by count([OrderID]) desc
15. Tính tổng số hóa đơn và tổng tiền của mỗi nhân viên đã bán trong tháng
3/1997, có tổng tiền >4000, thông tin gồm [EmployeeID],[LastName],
[FirstName], countofOrderid, sumoftotal
select O.[EmployeeID],FULLNAME = [LastName]+' '+[FirstName],CountOfOderID = count(O.[OrderID]),SumOfTotal = sum([UnitPrice]*[Quantity])
from [dbo].[Employees] E join [dbo].[Orders] O on E.EmployeeID = O.EmployeeID
join [dbo].[Order Details] OD on O.OrderID = OD.OrderID
where MONTH([OrderDate])=3 and YEAR([OrderDate])=1997
group by O.[EmployeeID],[LastName]+' '+[FirstName]
having sum([UnitPrice]*[Quantity])>4000

