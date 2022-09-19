1.

select
	date(website_sessions.created_at),
    count(website_sessions.website_session_id) as sessions,
	count(orders.website_session_id) as orders
	
from website_sessions
	left join orders
		on website_sessions.website_session_id=orders.website_session_id
where utm_source='gsearch' and website_sessions.created_at< '2012-11-27'

group by yearweek(website_sessions.created_at);


2.

select
	date(website_sessions.created_at) as weeks,
    count(website_sessions.website_session_id) as brand_sessions,
	count(orders.website_session_id) as brand_orders
	
from website_sessions
	left join orders
		on website_sessions.website_session_id=orders.website_session_id
where utm_source='gsearch' 
	and website_sessions.created_at< '2012-11-27'
    and website_sessions.utm_campaign='brand'

group by 
	yearweek(website_sessions.created_at);
    
select
	date(website_sessions.created_at) as weeks,
    count(website_sessions.website_session_id) as non_brand_sessions,
	count(orders.website_session_id) as non_brand_orders
	
from website_sessions
	left join orders
		on website_sessions.website_session_id=orders.website_session_id
where utm_source='gsearch' 
	and website_sessions.created_at< '2012-11-27'
    and website_sessions.utm_campaign='nonbrand'

group by 
	yearweek(website_sessions.created_at);
    
    
3.

select
	year(website_sessions.created_at) as years,	
	month(website_sessions.created_at) as months,
    count(case when device_type = 'desktop' then website_sessions.website_session_id else null end) as desk_sessions,
	count(case when device_type = 'desktop' then orders.website_session_id else null end) as desk_orders,
    count(case when device_type = 'mobile' then website_sessions.website_session_id else null end) as mobile_sessions,
	count(case when device_type = 'mobile' then orders.website_session_id else null end) as mobile_orders

from website_sessions
	left join orders
		on website_sessions.website_session_id=orders.website_session_id
where utm_source='gsearch' 
	and website_sessions.created_at< '2012-11-27'
    and website_sessions.utm_campaign='nonbrand'

group by 
	month(website_sessions.created_at);

4. 

select
	month(website_sessions.created_at) as months,
    count(case when utm_source = 'gsearch' then website_sessions.website_session_id else null end) as gsearch,
    count(case when utm_source = 'bsearch' then website_sessions.website_session_id else null end) as bsearch,
    count(case when utm_source = 'socialbook' then website_sessions.website_session_id else null end) as socialbook,
    count(case when utm_source = null then website_sessions.website_session_id else null end) as Nulll
	
from website_sessions
	left join orders
		on website_sessions.website_session_id=orders.website_session_id
where  website_sessions.created_at< '2012-11-27'
 
group by 
	month(website_sessions.created_at);
    
    
5. 

select
	month(website_sessions.created_at) as months,
    count(website_sessions.website_session_id) as sessions,
	count(orders.website_session_id) orders,
	count(orders.website_session_id)/count(website_sessions.website_session_id) as conversion_rate
from website_sessions
	left join orders
		on website_sessions.website_session_id=orders.website_session_id
where  website_sessions.created_at <= '2012-11-28'
 
group by 
	1;

    
6.

create temporary table page_lander
SELECT * FROM website_pageviews
where pageview_url in ('/lander-1','/lander-2','/lander-3','/lander-4') 
	and created_at > '2012-06-19' 
    and created_at < '2012-07-28';
select * from page_lander;

create temporary table page_lander_sessions
select
	page_lander.website_session_id,
    page_lander.pageview_url    
from page_lander
	left join website_sessions
		on page_lander.website_session_id=website_sessions.website_session_id
where utm_source='gsearch' and utm_campaign='nonbrand';


select
	sum(price_usd)-sum(cogs_usd) as revenue
from page_lander_sessions
	inner join orders
		on page_lander_sessions.website_session_id=orders.website_session_id;
        


7. 


create temporary table page_lander
SELECT * FROM website_pageviews
where pageview_url in ('/lander-1','/lander-2','/lander-3','/lander-4') 
	and created_at > '2012-06-19' 
    and created_at < '2012-07-28';
select * from page_lander;

create temporary table page_lander_sessions
select
	page_lander.website_session_id,
    page_lander.pageview_url    
from page_lander
	left join website_sessions
		on page_lander.website_session_id=website_sessions.website_session_id
where utm_source='gsearch' and utm_campaign='nonbrand';
select * from page_lander_sessions;

select
	sum(price_usd)-sum(cogs_usd) as revenue
from page_lander_sessions
	inner join orders
		on page_lander_sessions.website_session_id=orders.website_session_id;
        

