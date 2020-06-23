with companies as (

    select *
    from {{ var('company') }}

), engagements as (

    select *
    from {{ ref('hubspot__engagements') }}

), engagement_companies as (

    select *
    from {{ var('engagement_company') }}

), engagement_companies_joined as (

    select
        engagements.engagement_type,
        engagement_companies.company_id
    from engagements
    inner join engagement_companies
        using (engagement_id)

), engagement_companies_agg as (

    {{ engagements_aggregated('engagement_companies_joined', 'company_id') }}

), joined as (

    select 
        companies.*,
        {% for metric in engagement_metrics() %}
        coalesce(engagement_companies_agg.{{ metric }},0) as {{ metric }} {% if not loop.last %},{% endif %}
        {% endfor %}
    from companies
    left join engagement_companies_agg
        using (company_id)

)

select *
from joined