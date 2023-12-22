import gleam/io
import gleam/dict
import envoy

pub fn main() {
  // All
  let all = envoy.all()
  let assert Ok(_) = dict.get(all, "LANG")
  let assert Error(_) = dict.get(all, "UAGE")

  // Get, set
  let assert Error(_) = envoy.get("UAGE")
  envoy.set("UAGE", "anglish")
  let assert Ok("anglish") = envoy.get("UAGE")
  let all = envoy.all()
  let assert Ok("anglish") = dict.get(all, "UAGE")

  // Unset
  envoy.unset("UAGE")
  let assert Error(_) = envoy.get("UAGE")
  let all = envoy.all()
  let assert Error(_) = dict.get(all, "UAGE")

  io.println("All good sweetie 💕")
}
