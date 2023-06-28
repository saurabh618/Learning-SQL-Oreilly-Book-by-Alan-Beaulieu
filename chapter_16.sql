SELECT MONTHNAME(payment_date), QUARTER(payment_date), SUM(amount) FROM payment
WHERE payment_date BETWEEN '2005-05-01' AND '2005-09-01'
GROUP BY MONTHNAME(payment_date), QUARTER(payment_date);

SELECT MONTHNAME(payment_date) month, QUARTER(payment_date) quarter, SUM(amount) monthly_sales, 
MAX(SUM(amount)) OVER() max_overall_sales, MAX(SUM(amount)) OVER(PARTITION BY QUARTER(payment_date)) max_qrtr_sales,
RANK() OVER(ORDER BY SUM(amount) DESC) mn_sales_rank,
RANK() OVER(PARTITION BY QUARTER(payment_date) ORDER BY SUM(amount) DESC) qtr_sales_rank
FROM payment
WHERE payment_date BETWEEN '2005-05-01' AND '2005-09-01'
GROUP BY MONTHNAME(payment_date), QUARTER(payment_date)
ORDER BY quarter;

SELECT customer_id, COUNT(*),
ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC),
RANK() OVER(ORDER BY COUNT(*) DESC),
DENSE_RANK() OVER(ORDER BY COUNT(*) DESC)
FROM rental
GROUP BY customer_id
ORDER BY 2 DESC;

SELECT * FROM 
(SELECT customer_id, MONTHNAME(rental_date), COUNT(*),
RANK() OVER(PARTITION BY MONTHNAME(rental_date) ORDER BY COUNT(*) DESC) rank_per_mn
FROM rental
GROUP BY MONTHNAME(rental_date), customer_id
ORDER BY 2,4
) rank_tbl
WHERE rank_tbl.rank_per_mn <=5 ;

SELECT MONTHNAME(payment_date) payment_mn, amount, 
SUM(amount) OVER(PARTITION BY MONTHNAME(payment_date)) month_total, 
SUM(amount) OVER() grand_total
FROM payment
WHERE amount >= 10;

SELECT MONTHNAME(payment_date) payment_mn, SUM(amount) month_total,
ROUND (SUM(amount)/SUM(SUM(amount)) OVER() * 100,2) percentage_of_tot
FROM payment
GROUP BY payment_mn;

SELECT MONTHNAME(payment_date) payment_mn, SUM(amount) month_total,
CASE SUM(amount)
WHEN MAX(SUM(amount)) OVER() THEN 'Highest'
WHEN MIN(SUM(amount)) OVER() THEN 'Lowest'
ELSE 'Middle'
END ranking
FROM payment
GROUP BY payment_mn;

SELECT yearweek(payment_date) payment_week,
sum(amount) week_total,
sum(sum(amount))
	over (order by yearweek(payment_date)
	rows unbounded preceding) rolling_sum
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT yearweek(payment_date) payment_week,
sum(amount) week_total,
avg(sum(amount))
over (order by yearweek(payment_date)
rows between 1 preceding and 1 following) rolling_3wk_avg
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT date(payment_date), sum(amount),
avg(sum(amount)) over (order by date(payment_date)
range between interval 3 day preceding
and interval 3 day following) 7_day_avg
FROM payment
WHERE payment_date BETWEEN '2005-07-01' AND '2005-09-01'
GROUP BY date(payment_date)
ORDER BY 1;

SELECT yearweek(payment_date) payment_week,
sum(amount) week_total,
lag(sum(amount), 1)
over (order by yearweek(payment_date)) prev_wk_tot,
lead(sum(amount), 1)
over (order by yearweek(payment_date)) next_wk_tot
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT yearweek(payment_date) payment_week,
sum(amount) week_total, ROUND(((sum(amount) -
lag(sum(amount), 1) over (order by yearweek(payment_date))) / lag(sum(amount), 1) over (order by yearweek(payment_date))*100,2))  prev_wk_tot,
lead(sum(amount), 1)
over (order by yearweek(payment_date)) next_wk_tot
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT f.title,
group_concat(a.last_name order by a.last_name
separator ', ') actors
FROM actor a
INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
INNER JOIN film f
ON fa.film_id = f.film_id
GROUP BY f.title
HAVING count(*) = 3;

SELECT year_no, month_no, tot_sales,
RANK() OVER(PARTITION by year_no ORDER BY tot_sales DESC) sales_rank
FROM sales_fact;

SELECT year_no, month_no, tot_sales,
LAG(tot_sales,1) OVER(ORDER BY month_no)
FROM sales_fact
WHERE year_no = 2020;
