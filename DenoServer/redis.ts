import {
  GlideClient,
  GlideClusterClient,
  Logger,
} from "npm:@valkey/valkey-glide";
const addresses = [
  {
    host: "localhost",
    port: 6379,
  },
];
export const redis = await GlideClient.createClient({
  addresses: addresses,
  requestTimeout: 100, // 500ms timeout
  clientName: "AirNet",
});

//export const redis = createClient({  url: Deno.env.get("redis") ?? "redis://localhost:6379",});
try {
  //await redis.connect();

  const set_response = await redis.set("foo", "bar");
  console.log("[Redis] Connected!");
} catch (_error) {
  console.error("[Redis] Can't connect to the DB!");
  Deno.exit();
}
