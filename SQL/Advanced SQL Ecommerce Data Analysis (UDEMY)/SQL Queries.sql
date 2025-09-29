-- Task 1: Final Project number 6
-- the query in cte version

with after_products_page as
(select 
	p1.website_pageview_id,
    p1.created_at,
    p1.website_session_id,
    p1.pageview_url,
    p2.website_pageview_id website_pageview_id_after,
    p2.pageview_url pageview_url_after
from website_pageviews p1 left join website_pageviews p2 on p1.website_session_id=p2.website_session_id
and p2.website_pageview_id > p1.website_pageview_id 
where p1.pageview_url = '/products'),
pageviews_after_products as
(select 
	website_pageview_id,
    created_at,
    website_session_id,
    pageview_url,
    count(distinct pageview_url_after) pageview_after_products
from after_products_page group by 1,2,3,4)
SELECT 
    YEAR(p.created_at) year,
    MONTH(p.created_at) month,
    COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN p.website_session_id ELSE NULL END) sessions_of_products,
    COUNT(DISTINCT CASE WHEN p.pageview_after_products > 0 THEN p.website_session_id
            ELSE NULL END) clicked_to_next_page,
    COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN o.order_id
            ELSE NULL END) orders,
    COUNT(DISTINCT CASE WHEN p.pageview_after_products > 0 THEN p.website_session_id
            ELSE NULL END) / COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN p.website_session_id
            ELSE NULL END) clickthrough_rate,
    COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN o.order_id
            ELSE NULL END) / COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN p.website_session_id
            ELSE NULL END) products_to_order_rt 
FROM pageviews_after_products p LEFT JOIN orders o ON p.website_session_id = o.website_session_id
GROUP BY 1 , 2;


-- the query in temporary table version

create temporary table after_products_page
select 
	p1.website_pageview_id,
    p1.created_at,
    p1.website_session_id,
    p1.pageview_url,
    p2.website_pageview_id website_pageview_id_after,
    p2.pageview_url pageview_url_after
from website_pageviews p1 left join website_pageviews p2 on p1.website_session_id=p2.website_session_id
and p2.website_pageview_id > p1.website_pageview_id 
where p1.pageview_url = '/products';

create temporary table pageviews_after_products
select 
	website_pageview_id,
    created_at,
    website_session_id,
    pageview_url,
    count(distinct pageview_url_after) pageview_after_products
from after_products_page group by 1,2,3,4;

SELECT 
    YEAR(p.created_at) year,
    MONTH(p.created_at) month,
    COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN p.website_session_id ELSE NULL END) sessions_of_products,
    COUNT(DISTINCT CASE WHEN p.pageview_after_products > 0 THEN p.website_session_id
            ELSE NULL END) clicked_to_next_page,
    COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN o.order_id
            ELSE NULL END) orders,
    COUNT(DISTINCT CASE WHEN p.pageview_after_products > 0 THEN p.website_session_id
            ELSE NULL END) / COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN p.website_session_id
            ELSE NULL END) clickthrough_rate,
    COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN o.order_id
            ELSE NULL END) / COUNT(DISTINCT CASE WHEN p.pageview_url = '/products' THEN p.website_session_id
            ELSE NULL END) products_to_order_rt 
FROM pageviews_after_products p LEFT JOIN orders o ON p.website_session_id = o.website_session_id
GROUP BY 1 , 2;


-- Task 2: Middle Project number 6
SELECT 
    MIN(website_pageview_id)
FROM
    website_pageviews
WHERE
    pageview_url = '/lander-1';

-- mendapatkan pageview pertama untuk setiap session sebelum 28 Juli 2012 (test lander berakhir) dan dimulai dari
-- pageview awal lander-1 dipakai yakni 23504
create temporary table first_lander_per_sess
select 
	s.website_session_id, 
    min(p.website_pageview_id) min_pageview_id
from website_sessions s left join website_pageviews p on s.website_session_id=p.website_session_id
where 
	s.created_at < '2012-07-28' and
    p.website_pageview_id >= 23504 and
    s.utm_source = 'gsearch' and
    s.utm_campaign = 'nonbrand'
group by 1;
    
-- bring landing page for each session but restrict it to home or lander-1 (home sebagai metriks pembanding)
SELECT 
    *
FROM
    website_pageviews;
SELECT 
    *
FROM
    first_lander_per_sess;

create temporary table nonbrand_test_session_w_landing_pages
select f.*, p.pageview_url first_page 
from  first_lander_per_sess f left join website_pageviews p 
on p.website_pageview_id=f.min_pageview_id
where p.pageview_url in ('/home','/lander-1');

-- make a table that present the order_id for each landing session
create temporary table nonbrand_test_session_w_orders
select n.*, o.order_id
from nonbrand_test_session_w_landing_pages n 
left join orders o on n.website_session_id=o.website_session_id;

-- find the difference between the conversion rate
create temporary table comparison_home_lander1
select 
	distinct first_page,
    count(distinct website_session_id) sessions,
    count(distinct order_id) orders,
    count(distinct order_id)/count(distinct website_session_id) conv_rate
from nonbrand_test_session_w_orders
group by 1;

-- find the last session of page /home dipakai sebelum 27 Nov 
SELECT 
    MAX(s.website_session_id)
FROM
    website_pageviews p
        LEFT JOIN
    website_sessions s ON p.website_session_id = s.website_session_id
WHERE
    s.created_at < '2012-11-27'
        AND s.utm_source = 'gsearch'
        AND s.utm_campaign = 'nonbrand'
        AND p.pageview_url = '/home';

SELECT 
    MAX(s.created_at)
FROM
    website_pageviews p
        LEFT JOIN
    website_sessions s ON p.website_session_id = s.website_session_id
WHERE
    s.created_at < '2012-11-27'
        AND s.utm_source = 'gsearch'
        AND s.utm_campaign = 'nonbrand'
        AND p.pageview_url = '/home';


-- kita ingin tahu kenaikan order rate yang kita dapatkan setelah full menggunakan /lander-1 page sebagai landing page
-- selisih rate sebelumnya pada table
SELECT 
    *
FROM
    comparison_home_lander1;
SELECT 0.0406 - 0.0318;
-- kenaikan sebesar 0.0088 apabila kita menggunakan lander-1
-- maka kenaikan order rate yang akan kita dapatkan setelah test lander adalah 0.0088*sessions (sessions setelah test lander dan sebelum 27 nov)

SELECT 
    COUNT(DISTINCT website_session_id)
FROM
    website_sessions
WHERE
    website_session_id > 17145
        AND created_at < '2012-11-27'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand';

-- sebanyak 22972 sessions setelahnya
-- sehingga kenaikan order yang akan masuk dari 22972 sessions tersebut adalah 0.0088*22972 
SELECT 0.0088 * 22972;
-- sebanyak 202 kenaikan order dari biasanya (sebelumnya menggunakan /home)
-- kita telah menaikkan 202 order sejak test /lander-1 tersebut selesai 7/28 (menggunakan /lander-1 setelahnya (7/29))

