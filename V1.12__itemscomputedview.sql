DROP VIEW IF EXISTS VIEW "public"."item_computed";

CREATE OR REPLACE VIEW "public"."item_computed" AS SELECT items.item_id,
    items.item_name,
    items.subcategory_id,
    items.brand_id,
    items.date_add,
    items.date_upd,
    items.slug,
    min(item_inventory.price) AS min_price,
    count(item_inventory.inventory_id) AS no_of_inventory
   FROM ((items
     LEFT JOIN item_variant ON ((item_variant.item_id = items.item_id)))
     LEFT JOIN item_inventory ON (((item_variant.variant_id = item_inventory.variant_id) AND (item_inventory.status = 'published'::text))))
  GROUP BY items.item_id;;

