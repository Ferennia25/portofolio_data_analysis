![Image](https://github.com/user-attachments/assets/72221683-2632-44e3-adec-c668252ff15a)

### Hi! This is Ferennia

I want to share some example cases we must solve as data analysts. Sometimes, our stakeholders need data to identify what’s happening with the business trends, level up the business, make it sustainable, and increase upselling. As data analysts, it’s our job to help them analyse all the data so that we have insight and the right answer that can actually help them.

**DISCLAIMER**: All the database and task project questions are from *Advanced SQL: MySQL for Ecommerce Data Analysis* by John Pauler. He tutors the course in Udemy. I share my answer for some questions or tasks in the mid-project and final-project that John asked in the course. I also picked some unique and challenging tasks that I think are very useful to help us get advanced skills in query. Hope this inspires you to help you learn and understand more about SQL. Enjoy!🙂

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

### Task 2: Middle Project number 6

_For the gsearch lander test, please estimate the revenue that test earned us (Hint: look at the increase in CVR from the test (Jun 19-Jul 28), and use nonbrand sessions and revenue since then to calculate incremental value) and also limit the time observation till 27 Nov 2012._

Before we jump into Step 1, I’d like to share with you the type of first page that customers visited before November 27, 2012, which were/home and /lander-1 pages. This task’s purpose is to find the best landing page that has a better conversion rate to orders, which we’re going to test between June 19 and July 28, 2012. After we find out the best lander, we need to calculate the escalation rate after changing the lander page to be the best lander.

**Step 1**. Know the first website_pageview_id that indicates ‘/lander-1’

![Image](https://github.com/user-attachments/assets/6677df1a-350d-47de-ad01-7832baf45d30)

The result:

![Image](https://github.com/user-attachments/assets/5f0372c3-33b3-4155-aff7-c443edae3d34)

**Step 2.** In this step we’re going to find the lander page of every session that happened before July 28 (the end of the lander test) and after the minimum of website_pageview_id that indicates /lander-1 which is the first /lander-1 ever. We also limit the type of utm_source and utm_campaign because we’re asked to observe those types of marketing channels that are used.

![Image](https://github.com/user-attachments/assets/cee447a0-bec6-43d6-a8cf-eafecb934477)

We can also see the result of the query above with,

select * from first_lander_per_sess;

The result must be like this,

![Image](https://github.com/user-attachments/assets/a0598f17-410a-49f9-b992-05f0f4e4a110)

**Step 3.** The third step, we’re going to find the type of lander pages that happened to every website_session_id from the first_lander_per_sess table.

![Image](https://github.com/user-attachments/assets/63388cbf-befa-43ab-a353-0c766257977e)

We can also see the result of the query above with,

select * from nonbrand_test_session_w_landing_pages;

The result must be like this,

![Image](https://github.com/user-attachments/assets/58a5a9f1-f4c1-4587-a813-4856dd149d7f)

**Step 4.** We also want to know the website_session_id that made it to orders, so we make this temporary table with a basic left join.

![Image](https://github.com/user-attachments/assets/dd024c80-5920-49f8-b921-b417628598fc)

We can also see the result of the query above with,

select * from nonbrand_test_session_w_orders;

The result must be like this,

![Image](https://github.com/user-attachments/assets/276a8a3b-af4b-457b-b0ea-e09b0458d1c1)

**Step 5.** Here we are, we finally can see the difference between /home and /lander-1 make it to orders, and how the conversion rates are.

![Image](https://github.com/user-attachments/assets/f9335d5b-3057-4dba-98a8-3643a8743d7e)

We can also see the result of the query above with,

select * from comparison_home_lander1;

The result must be like this,

<!-- Failed to upload "1_R9yG-S0YOSPPqnWxf0Z08A.webp" -->

With these queries, we know that 17145 is the last website_session_id when the lander page is /home (after the company made a test between /home and /lander-1 and found out /lander-1 was the best lander page), and the last /home lander page used is in July 29, 2012 (kindly remind that we limit the created_at to 2012–11–27 because we observed that range period).

![Image](https://github.com/user-attachments/assets/c78f80f0-d683-4b8c-97ff-ec67f8e416db)

The result:

![Image](https://github.com/user-attachments/assets/b1940beb-0e80-4f06-a83e-2c0dca4c770f)
![Image](https://github.com/user-attachments/assets/ed1060ad-711e-4b05-8c2b-379abbd2a054)

After that, the amount of sessions that happen can be counted.

![Image](https://github.com/user-attachments/assets/4193d7df-c906-4c05-9c78-379cc3453c16)

The result:

![Image](https://github.com/user-attachments/assets/f73152af-edb9-4425-826d-aabface6aeed)

There were 22972 sessions after the company made all the customers’ lander page is /lander-1. We got the conversion rate from /home and /lander-1 page before, there are 0.0406 and 0.0318.

If we see the difference between the conversion rate,

![Image](https://github.com/user-attachments/assets/27803a87-a317-4522-94ad-65060476981f)
![Image](https://github.com/user-attachments/assets/951dd9e2-c909-47f6-841d-58f8ccef3d1d)

That would be 0.0088 of escalations of the lander page, which will make it to orders if we change the lander page from /home to fully /lander-1. That means if we multiply 22972 and 0.0088,

![Image](https://github.com/user-attachments/assets/65bba45f-0d99-46fd-8de8-9894598b24a4)
![Image](https://github.com/user-attachments/assets/c811fdbf-98e8-455d-900a-d06fd22e3475)

there was an increase of 202 orders from usual (the company used only /home as the landing page before the test). So, the company got 202 more orders after using only /lander-1 as a lander page.


