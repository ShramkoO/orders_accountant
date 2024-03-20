// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { supabaseClient } from '../_shared/supabaseClient.ts';

console.log("on-order-updated function startup");



Deno.serve(async (req) => {
  const payload = await req.json();
  console.log(JSON.stringify(payload, null, 2));

  return new Response('ok');
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/on-order-updated' \
    --header 'Authorization: Bearer ' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
