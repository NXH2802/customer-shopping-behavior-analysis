-- Q1 Nhóm tuổi nào đóng góp doanh thu nhiều 
SELECT age_group,
       COUNT(*) AS total_customers,
       ROUND(AVG(purchase_amount),2) AS avg_spend,
       ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer_data
GROUP BY age_group
ORDER BY total_revenue DESC;

-- Q2 Doanh thu theo giới tính 
SELECT gender,
       ROUND(SUM(purchase_amount),2) AS revenue
FROM customer_data
GROUP BY gender;

-- Q3 Phân khúc khách hàng
WITH customer_segment AS
(
SELECT *,
CASE
    WHEN previous_purchases = 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
    ELSE 'Loyal'
END AS segment
FROM customer_data
)

SELECT segment,
       COUNT(*) customers
FROM customer_segment
GROUP BY segment;

-- Q4 Danh mục nào tạo doanh thu cao nhất
SELECT category,
       ROUND(SUM(purchase_amount),2) revenue
FROM customer_data
GROUP BY category
ORDER BY revenue DESC;

-- Q5 Top 10 sản phẩm bán chạy nhất
SELECT item_purchased,
       COUNT(*) total_orders
FROM customer_data
GROUP BY item_purchased
ORDER BY total_orders DESC
LIMIT 10;

-- Q6 Top 5 sản phẩm được đánh giá cao nhất
SELECT item_purchased,
       ROUND(AVG(review_rating)::numeric, 2) AS avg_rating
FROM customer_data
GROUP BY item_purchased
ORDER BY avg_rating DESC
LIMIT 5;

-- Q7 sub có làm khách hàng mua nhiều hơn không?
SELECT subscription_status,
       ROUND(AVG(purchase_amount),2) avg_spend,
       ROUND(SUM(purchase_amount),2) total_revenue
FROM customer_data
GROUP BY subscription_status;

-- Q8 Subscription có làm khách hàng quay lại nhiều hơn không?
SELECT subscription_status,
       ROUND(AVG(previous_purchases),2) avg_previous_purchases
FROM customer_data
GROUP BY subscription_status;

-- Q9: Discount có giúp tăng giá trị đơn hàng không?
SELECT discount_applied,
       ROUND(AVG(purchase_amount),2) avg_order_value
FROM customer_data
GROUP BY discount_applied;

-- Q10: Sản phẩm nào phụ thuộc vào giảm giá?
SELECT item_purchased,
       ROUND(
       100.0*
       SUM(CASE WHEN discount_applied='Yes' THEN 1 ELSE 0 END)
       /COUNT(*),2) discount_rate
FROM customer_data
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;
-- Q11: Mùa nào tạo doanh thu cao nhất?
SELECT season,
       ROUND(SUM(purchase_amount),2) revenue
FROM customer_data
GROUP BY season
ORDER BY revenue DESC;

-- Q12: Hình thức giao hàng nào có giá trị đơn hàng cao hơn?
SELECT shipping_type,
       ROUND(AVG(purchase_amount),2) avg_order_value
FROM customer_data
GROUP BY shipping_type
ORDER BY avg_order_value DESC;
