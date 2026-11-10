import { describe, it } from "node:test";
import assert from "node:assert/strict";

describe("app", () => {
  it("returns greeting message", () => {
    const message = "Hello, World!";
    assert.equal(message, "Hello, World!");
  });
});
