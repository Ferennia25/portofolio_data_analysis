![Image](https://github.com/user-attachments/assets/72221683-2632-44e3-adec-c668252ff15a)

### Hi! This is Ferennia

I want to share some example cases we must solve as data analysts. Sometimes, our stakeholders need data to identify what’s happening with the business trends, level up the business, make it sustainable, and increase upselling. As data analysts, it’s our job to help them analyse all the data so that we have insight and the right answer that can actually help them.

**DISCLAIMER**: All the database and task project questions are from Advanced SQL: MySQL for Ecommerce Data Analysis by John Pauler. He tutors the course in Udemy. I share my answer for some questions or tasks in the mid-project and final-project that John asked in the course. I also picked some unique and challenging tasks that I think are very useful to help us get advanced skills in query. Hope this inspires you to help you learn and understand more about SQL. Enjoy!🙂

This is the Entity Relationship Model of the **MavenFuzzyFactory** database, so basically, these are the common ecommerce data tables that are usually used. We can see which one is the primary key or the foreign key in every table of data. For instance, in website_sessions, we have website_session_id as primary key, but website_session_id is a foreign key in website_pageviews table.


![Image](https://github.com/user-attachments/assets/259cff62-b329-4670-a838-d60d5b84acbc)

### Task 1: Final Project number 6

_Let’s dive deeper into the impact of introducing new products. Please pull monthly sessions to the /products page, and show how the % of those sessions clicking through another page has changed over time, along with a view of how conversion from /products to placing an order has improved._

**Step 1**. We will find monthly sessions to /product page and the conversion rate from /product page to the next page (click rate), so we’re gonna use the website_pageviews table. In this step, we need to use website_pageview_id of every session, created_at so that we can make the monthly data, website_session_id which presents every session that happens containing multiple website_pageview_id of every session, and also pageview_url that identifies what type of page occurs on every single website_pageview_id. The main point that I did on my query is I made pageview_url that happens after pageview_url of every website_pageview_id which indicates the next page, if it’s null then the customer did not click anything on the /product page; they just basically left the page. The pageview_url_after is defined by the visited pages after the customer clicked on the /product page, and it has a higher website_pageview_id in value. Since we focus on /products, we must limit the pageview_url on the/products page only.


![Image](https://github.com/user-attachments/assets/0b06d900-4710-4f8c-8f84-ed5af0143114)

We can also see the result of the query above with,

select * from after_products_page;

The result must be like this,

![Image](https://github.com/user-attachments/assets/c853cd33-de45-43b5-9982-db162c7df38c)


**Step 2.** After creating the after_products_page table, we use it to find how many pages the customer visited after the /product page. If it’s 0, then the customer didn’t click anything after they reached the /product page. Why did I group the tables by 1,2,3,4? It’s because I made an aggregation on counting pageview_url pages that were visited by customers on every session.


![Image](https://github.com/user-attachments/assets/0b72e77d-30f5-4aa1-954d-f5fc217ab9db)

We can also see the result of the query above with,

select * from pageviews_after_products;

The result must be like this,


![Image](https://github.com/user-attachments/assets/db4e88fc-83c3-4f5f-aba5-0e5261fb8abf)


**Step 3**. For this last step, we have made pageviews_after_products temporary tables and will use them to make the final result. First, we have to list monthly time, definitely year and month, and then make multiples aggregations. Column of session_of_products is made from the condition when pageview_url equals to /products then we count the unique of website_session_id to get the number of sessions that visited the /product page. The clicked_to_next_page comes from the condition when pageview_after_products has more than 0 in value because that means the customer visited or clicked anything page after the /product page. We’re also going to find how many orders from the /product page that happened, so we have to join the orders table to pageviews_after_products on website_session_id (since it’s on both tables) and also don’t forget to make pageview_url’s condition only on /products page. The last but not least, we’re going to make clickthrough_rate and products_to_order_rt that basically rates of next page amounts and orders amount. That’s absolutely the answer of ‘_how much rate of people click after visited /product page and also make an order?_’

![Image](https://github.com/user-attachments/assets/e7348b9a-0537-443f-9b5d-3f0fbf4edf2c)

The result must be like this,

![Image](https://github.com/user-attachments/assets/0d5bd575-aefc-4866-9bc3-c84d057ee27a)


The result shows that the clickthrough rate of the /products page is getting better, as is the rate of /products ‘ page visitors who make an order. This insight is very useful for any stakeholders or business analysts to know that the company has been doing better over time. We can decide what steps to take next to sustain it or even make better upselling in the future.
