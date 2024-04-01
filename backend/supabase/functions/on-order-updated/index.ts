// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { supabaseClient } from '../_shared/supabase_client.ts';

console.log("on-order-updated function startup");

Deno.serve(async (req) => {
  const payload = await req.json();
  console.log(JSON.stringify(payload, null, 2));

  const order = payload.record;
  const oldOrder = payload.old_record;

  console.log(order);
  console.log(oldOrder);

  let data, error;

  let orderStatus = order.status;
  let oldOrderStatus = oldOrder ? oldOrder.status : null;

  if (orderStatus !== oldOrderStatus) {
    console.log(`Order ${order.id} status changed from ${oldOrderStatus} to ${order.status}`);

    if (!oldOrder && order.status === 'pending') {
      console.log(`Order ${order.id} was created`);

      console.log("order.products_detailed");
      console.log(order.products_detailed);
      console.log("order.products");
      console.log(order.products);
      //update products db quantity_ordered
      var product_ids = [];
      var quantities = [];
      for (var product_id of order.products) {
        console.log('product_id', product_id)
        console.log(product_id);
        product_ids.push(product_id);
        quantities.push(order.products_detailed[product_id].quantity);
      }



      //call db function to update quantity_ordered
      ({ data, error } = await supabaseClient.rpc('update_product_column',
        {
          column_name: 'quantity_ordered',
          ids: product_ids,
          increment_values: quantities
        }));

      //({ data, error } = await supabaseClient.rpc('increment', { x: 1, row_id: 2 }));
      console.log("product_ids");
      console.log(product_ids);
      console.log("quantities");
      console.log(quantities);
      if (error) console.error(error)
      else console.log(data);
    }

    if (oldOrder && order.status === 'completed') {
      console.log(`Order ${order.id} was completed`);

      //update products db quantity_ordered
      var product_ids = [];
      var quantities = [];
      var quantities_minus = [];
      for (product_id in order.products) {
        product_ids.push(product_id);
        quantities.push(order.products_detailed[product_id].quantity); // with minus
        quantities_minus.push(- order.products_detailed[product_id].quantity); // with minus
      }
      //call db function to update quantity_ordered
      ({ data, error } = await supabaseClient.rpc('update_product_column',
        {
          column_name: 'quantity_ordered',
          ids: product_ids,
          increment_values: quantities_minus
        }));
      if (error) console.error(error)
      else console.log(data);

      ({ data, error } = await supabaseClient.rpc('update_product_column',
        {
          column_name: 'quantity',
          ids: product_ids,
          increment_values: quantities_minus
        }));
      if (error) console.error(error)
      else console.log(data);

      ({ data, error } = await supabaseClient.rpc('update_product_column',
        {
          column_name: 'quantity_sold',
          ids: product_ids,
          increment_values: quantities
        }));
      if (error) console.error(error)
      else console.log(data);


    }



  }
  return new Response('ok');
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/on-order-updated' \
    --header 'Authorization: Bearer ' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
