import { Result$Ok, Result$Error } from "./gleam.mjs";
import { new$ as newDict, insert } from "../gleam_stdlib/gleam/dict.mjs";

export function get(key) {
  let value;

  if (globalThis.Deno) {
    value = Deno.env.get(key);
  } else if (globalThis.process) {
    value = process.env[key];
  }

  if (value === undefined) {
    return Result$Error(undefined);
  } else {
    return Result$Ok(value);
  }
}

export function set(key, value) {
  if (globalThis.Deno) {
    Deno.env.set(key, value);
  } else if (globalThis.process) {
    process.env[key] = value;
  }
}

export function unset(key) {
  if (globalThis.Deno) {
    Deno.env.delete(key);
  } else if (globalThis.process) {
    delete process.env[key];
  }
}

export function all() {
  let environmentVariables = {};

  if (globalThis.Deno) {
    environmentVariables = Deno.env.toObject();
  } else if (globalThis.process) {
    environmentVariables = process.env;
  }

  let result = newDict();
  for (let key in environmentVariables) {
    if (Object.hasOwn(environmentVariables, key)) {
      result = insert(result, key, environmentVariables[key]);
    }
  }

  return result;
}
