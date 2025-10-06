// ==UserScript==
// @name               YouTube - uBlock Scriptlets Port
// @description        Ported uBlock Origin scriptlets for YouTube ad blocking
// @match              https://www.youtube.com/*
// @match              https://m.youtube.com/*
// @grant              none
// @run-at             document-start
// ==/UserScript==

(function () {
  "use strict";

  // Scriptlet: set-constant (prevents ad detection)
  function setConstant(chain, value) {
    const props = chain.split(".");
    let obj = window;

    for (let i = 0; i < props.length - 1; i++) {
      obj = obj[props[i]] = obj[props[i]] || {};
    }

    Object.defineProperty(obj, props[props.length - 1], {
      value: value,
      writable: false,
      configurable: false,
    });
  }

  // Scriptlet: abort-on-property-read (blocks ad checks)
  function abortOnPropertyRead(prop) {
    const props = prop.split(".");
    let obj = window;

    for (let i = 0; i < props.length - 1; i++) {
      obj = obj[props[i]];
      if (!obj) return;
    }

    const lastProp = props[props.length - 1];
    let value;

    Object.defineProperty(obj, lastProp, {
      get: function () {
        throw new ReferenceError("Aborted");
      },
      set: function (v) {
        value = v;
      },
    });
  }

  // Scriptlet: remove-attr (strips ad attributes)
  function removeAttr(selector, attr) {
    const observer = new MutationObserver(() => {
      document.querySelectorAll(selector).forEach((el) => {
        el.removeAttribute(attr);
      });
    });

    observer.observe(document.documentElement, {
      childList: true,
      subtree: true,
    });

    // Initial cleanup
    document.querySelectorAll(selector).forEach((el) => {
      el.removeAttribute(attr);
    });
  }

  // Scriptlet: no-fetch-if (blocks ad requests)
  const originalFetch = window.fetch;
  window.fetch = function (...args) {
    const url = args[0];
    if (typeof url === "string") {
      // Block known ad endpoints
      if (
        url.includes("doubleclick.net") ||
        url.includes("googlesyndication.com") ||
        url.includes("pagead") ||
        url.includes("/api/stats/ads") ||
        url.includes("/get_midroll_info")
      ) {
        return Promise.reject(new Error("blocked"));
      }
    }
    return originalFetch.apply(this, args);
  };

  // Scriptlet: prevent-xhr (blocks XHR ad requests)
  const originalOpen = XMLHttpRequest.prototype.open;
  XMLHttpRequest.prototype.open = function (method, url, ...args) {
    if (typeof url === "string") {
      if (
        url.includes("doubleclick.net") ||
        url.includes("googlesyndication.com") ||
        url.includes("/api/stats/ads")
      ) {
        url = "about:blank";
      }
    }
    return originalOpen.call(this, method, url, ...args);
  };

  // YouTube-specific blocks
  setConstant("ytInitialPlayerResponse.adPlacements", undefined);
  setConstant("ytInitialPlayerResponse.playerAds", undefined);
  setConstant("playerResponse.adPlacements", undefined);
  setConstant("playerResponse.playerAds", undefined);

  // Prevent ad check functions
  try {
    abortOnPropertyRead("Object.prototype.adBlock");
    abortOnPropertyRead("Object.prototype.ads");
  } catch (e) {}

  // Remove ad-showing classes
  const checkAdClasses = () => {
    const player = document.querySelector("#movie_player, .html5-video-player");
    if (player) {
      player.classList.remove("ad-showing", "ad-interrupting");
    }
  };

  setInterval(checkAdClasses, 500);

  // Log scriptlet activation
  console.log("[uBlock Scriptlets] YouTube ad blocking active");
})();
