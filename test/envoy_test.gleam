import envoy
import gleam/dict
import gleam/io

pub fn main() {
  // All
  let all = envoy.all()
  let assert Ok(_) = dict.get(all, "LANG")
  let assert Error(Nil) = dict.get(all, "UAGE")

  // Get, set
  let assert Error(_) = envoy.get("UAGE")
  envoy.set("UAGE", "anglish")
  let assert Ok("anglish") = envoy.get("UAGE")
  let all = envoy.all()
  let assert Ok("anglish") = dict.get(all, "UAGE")

  // Unset
  envoy.unset("UAGE")
  let assert Error(Nil) = envoy.get("UAGE")
  let all = envoy.all()
  let assert Error(Nil) = dict.get(all, "UAGE")

  // Unicode
  envoy.set("WIBBLE", "🦄")
  let assert Ok("🦄") = envoy.get("WIBBLE")
  let all = envoy.all()
  let assert Ok("🦄") = dict.get(all, "WIBBLE")

  io.println("All good sweetie 💕")
}
