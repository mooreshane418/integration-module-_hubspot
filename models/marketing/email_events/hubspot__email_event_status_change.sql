{{ config(enabled=enabled_vars(['hubspot_marketing_enabled','hubspot_email_event_enabled','hubspot_email_event_status_change_enabled'])) }}

{{ email_events_joined(var('email_event_status_change')) }}