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
