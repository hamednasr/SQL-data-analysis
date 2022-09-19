1.

select
	year(website_sessions.created_at) as year,
	quarter(website_sessions.created_at) as quarter,
    count(website_sessions.website_session_id) as sessions,
    count(orders.website_session_id) as orders
    
from website_sessions
	left join orders
		on website_sessions.website_session_id=orders.website_session_id
group by 
	year(website_sessions.created_at),
	quarter(website_sessions.created_at);
    
***************************************************************************
2.

select

	year(website_sessions.created_at) as year,
	quarter(website_sessions.created_at) as quarter,
    count(website_sessions.website_session_id) as sessions,
    count(orders.website_session_id) as orders,
    count(orders.website_session_id)/count(website_sessions.website_session_id) as so_cvr,
    sum(orders.price_usd)/count(website_sessions.website_session_id) as rev_per_ses,
    sum(orders.price_usd)/count(orders.website_session_id) as rev_per_ord
    
from website_sessions
	left join orders
		on website_sessions.website_session_id=orders.website_session_id
group by 
	year(website_sessions.created_at),
	quarter(website_sessions.created_at);
    
***************************************************************************
3. 

select

	year(website_sessions.created_at) as year,
	quarter(website_sessions.created_at) as quarter,
	count(case when utm_source='gsearch' and utm_campaign='nonbrand' then orders.website_session_id else null end) as gsearch_nb,
	count(case when utm_source='bsearch' and utm_campaign='nonbrand' then orders.website_session_id else null end) as bsearch_nb,
	count(case when utm_campaign='brand' then orders.website_session_id else null end) as search_brand,
	count(case when utm_source is null and utm_campaign is null then orders.website_session_id else null end) as org_search,
	count(case when utm_source is null and utm_campaign is null and http_referer is null then orders.website_session_id else null end) as type_in
    
from website_sessions
	inner join orders
		on website_sessions.website_session_id=orders.website_session_id
group by 
	year(website_sessions.created_at),
	quarter(website_sessions.created_at);

***************************************************************************
4.


 select

	year(website_sessions.created_at) as year,
	quarter(website_sessions.created_at) as quarter,
    
	count(case when utm_source='gsearch' and utm_campaign='nonbrand' then orders.website_session_id else null end)/
		count(case when utm_source='gsearch' and utm_campaign='nonbrand' then website_sessions.website_session_id else null end) as sr_cvr_gsearch_nb,
        
	count(case when utm_source='bsearch' and utm_campaign='nonbrand' then orders.website_session_id else null end)/
		count(case when utm_source='bsearch' and utm_campaign='nonbrand' then website_sessions.website_session_id else null end) as sr_cvr_bsearch_nb,
        
	count(case when utm_campaign='brand' then orders.website_session_id else null end)/
		count(case when utm_campaign='brand' then website_sessions.website_session_id else null end)as sr_cvr_search_brand,
        
	count(case when utm_source is null and utm_campaign is null then orders.website_session_id else null end)/ 
		count(case when utm_source is null and utm_campaign is null then website_sessions.website_session_id else null end) as sr_cvr_org_search,
        
	count(case when utm_source is null and utm_campaign is null and http_referer is null then orders.website_session_id else null end)/
		count(case when utm_source is null and utm_campaign is null and http_referer is null then website_sessions.website_session_id else null end) as sr_cvr_type_in

from website_sessions
	left join orders
		on website_sessions.website_session_id=orders.website_session_id
group by 
	year(website_sessions.created_at),
	quarter(website_sessions.created_at);
    
***************************************************************************

5.

select

	year(order_items.created_at) as year,
	month(order_items.created_at) as month,
	sum(case when products.product_name='The Original Mr. Fuzzy' then order_items.price_usd else null end) as mr_fuzzy_rev,
	sum(case when products.product_name='The Original Mr. Fuzzy' then (order_items.price_usd-order_items.cogs_usd) else null end) as mr_fuzzy_mar,	
	count(case when products.product_name='The Original Mr. Fuzzy' then order_items.order_item_id else null end) as mr_fuzzy_sale,

	sum(case when products.product_name='The Forever Love Bear' then order_items.price_usd else null end) as love_bear_rev,
	sum(case when products.product_name='The Forever Love Bear' then (order_items.price_usd-order_items.cogs_usd) else null end) as love_bea_mar,	
	count(case when products.product_name='The Forever Love Bear' then order_items.order_item_id else null end) as love_bea_sale,

	sum(case when products.product_name='The Birthday Sugar Panda' then order_items.price_usd else null end) as sugar_pand_rev,
	sum(case when products.product_name='The Birthday Sugar Panda' then (order_items.price_usd-order_items.cogs_usd) else null end) as sugar_pand_mar,	
	count(case when products.product_name='The Birthday Sugar Panda' then order_items.order_item_id else null end) as sugar_pand_sale,
    
	sum(case when products.product_name='The Hudson River Mini bear' then order_items.price_usd else null end) as mn_bear_rev,
	sum(case when products.product_name='The Hudson River Mini bear' then (order_items.price_usd-order_items.cogs_usd) else null end) as mn_bear_mar,	
	count(case when products.product_name='The Hudson River Mini bear' then order_items.order_item_id else null end) as mn_bear_sale,
    
    sum(order_items.price_usd) as total_rev,
    sum(order_items.price_usd-order_items.cogs_usd) as total_marg
    
from order_items
	left join products
		on order_items.product_id=products.product_id
        
group by 
	year(order_items.created_at),
	month(order_items.created_at);
    
***************************************************************************

6.

select

	year(website_pageviews.created_at) as year,
	month(website_pageviews.created_at) as month,
    
    count(distinct website_pageviews.website_session_id) as sessions,
	count(case when website_pageviews.pageview_url='/products' then website_pageviews.website_pageview_id else null end) as products,

	count(case when website_pageviews.pageview_url='/products' then website_pageviews.website_pageview_id else null end)/ 
    count(distinct website_pageviews.website_session_id) as ses_pro_cvr,
	
    count(case when website_pageviews.pageview_url='/thank-you-for-your-order' then website_pageviews.website_pageview_id else null end)/
	count(case when website_pageviews.pageview_url='/products' then website_pageviews.website_pageview_id else null end) as pro_orser_cvr


from website_pageviews
	#left join orders
	#	on website_sessions.website_session_id=orders.website_session_id
group by 
	year(website_pageviews.created_at),
	quarter(website_pageviews.created_at)

order by
	year(website_pageviews.created_at),
	quarter(website_pageviews.created_at);
    
***************************************************************************



