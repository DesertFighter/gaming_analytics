{% docs fct_purchases_description %}
Purchase transactions from all players, enriched with spend tier classification
from the spend_tier_config seed. One row per purchase event.
{% enddocs %}

{% docs amount_description %}
The monetary amount of the purchase in USD. Always positive.
Joined with spend_tier_config to classify as Bronze / Silver / Gold / Platinum.
{% enddocs %}

{% docs player_id_description %}
Foreign key to dim_players. Every purchase must belong to a valid player.
{% enddocs %}