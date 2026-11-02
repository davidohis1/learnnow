// APP_URL is supplied by PHP, never inferred from the browser's hostname.
const encode = (value) =>
  encodeURIComponent(String(value)).replace(
    /[!'()*]/g,
    (c) => `%${c.charCodeAt(0).toString(16).toUpperCase()}`,
  );

export function createUrlTools(baseValue, currentUri = "/") {
  if (!baseValue || /[\s\\\x00-\x1f\x7f]/.test(baseValue))
    throw new Error("Invalid APP_URL configuration.");
  const base = new URL(baseValue);
  if (
    !["http:", "https:"].includes(base.protocol) ||
    base.username ||
    base.password ||
    base.search ||
    base.hash
  )
    throw new Error("Invalid APP_URL configuration.");
  const normalise = (path) => {
    if (/[\x00-\x20\x7f\\]/.test(path) || /%(?![0-9a-f]{2})/i.test(path))
      throw new Error("Invalid URL path.");
    const segments = path
      .split("/")
      .filter(Boolean)
      .map((segment) => {
        const value = decodeURIComponent(segment);
        if (value === "." || value === ".." || /[\x00-\x1f\x7f/\\]/.test(value))
          throw new Error("Unsafe URL path.");
        return encode(value);
      });
    const result = "/" + segments.join("/");
    return result !== "/" && path.endsWith("/") ? result + "/" : result;
  };
  const rawBasePath =
    baseValue.replace(/^[a-z][a-z\d+.-]*:\/\/[^/?#]*/i, "") || "/";
  const prefix = normalise(rawBasePath).replace(/\/$/, "");
  const root = base.origin + prefix;
  const split = (reference) => {
    if (/[\x00-\x1f\x7f\\]/.test(reference) || reference.startsWith("//"))
      throw new Error("Unsafe internal URL.");
    let remaining = reference;
    if (/^[a-z][a-z\d+.-]*:/i.test(reference)) {
      const absolute = new URL(reference);
      if (
        absolute.origin !== base.origin ||
        !["http:", "https:"].includes(absolute.protocol) ||
        absolute.username ||
        absolute.password
      )
        throw new Error("External URL is not an internal route.");
      remaining = reference.replace(/^[a-z][a-z\d+.-]*:\/\/[^/?#]*/i, "");
      const path = normalise(remaining.split(/[?#]/, 1)[0] || "/");
      if (prefix && path !== prefix && !path.startsWith(prefix + "/"))
        throw new Error("URL is outside this application.");
    }
    const hashIndex = remaining.indexOf("#");
    const fragment = hashIndex < 0 ? "" : remaining.slice(hashIndex + 1);
    if (hashIndex >= 0) remaining = remaining.slice(0, hashIndex);
    const queryIndex = remaining.indexOf("?");
    return {
      path: queryIndex < 0 ? remaining : remaining.slice(0, queryIndex),
      query: queryIndex < 0 ? "" : remaining.slice(queryIndex + 1),
      fragment,
    };
  };
  const pathFor = (uri) => {
    try {
      const raw = /^[a-z][a-z\d+.-]*:/i.test(uri)
        ? new URL(uri).pathname
        : uri.split(/[?#]/, 1)[0];
      if (!raw.startsWith("/") || raw.startsWith("//")) return null;
      const path = normalise(raw);
      if (!prefix) return path;
      if (path === prefix || path === prefix + "/") return "/";
      return path.startsWith(prefix + "/") ? path.slice(prefix.length) : null;
    } catch {
      return null;
    }
  };
  const mergeQuery = (original, extra) => {
    const entries = Object.entries(extra || {});
    if (!entries.length) return original;
    const keys = entries.map(([key]) => key);
    const result = original
      ? original
          .split("&")
          .filter(
            (pair) =>
              !keys.includes(
                decodeURIComponent(
                  pair.split("=", 1)[0].replaceAll("+", " "),
                ).split("[", 1)[0],
              ),
          )
      : [];
    const add = (key, value) => {
      if (value === null || value === undefined) return;
      if (typeof value === "object")
        Object.entries(value).forEach(([index, item]) =>
          add(`${key}[${index}]`, item),
        );
      else
        result.push(
          encode(key) +
            "=" +
            encode(typeof value === "boolean" ? Number(value) : value),
        );
    };
    entries.forEach(([key, value]) => add(key, value));
    return result.join("&");
  };
  const build = (
    reference = "",
    query = {},
    fragment = null,
    logical = false,
  ) => {
    reference = String(reference);
    const p = split(reference);
    let path;
    if (reference.startsWith("?") || reference.startsWith("#")) {
      path = pathFor(currentUri) || "/";
      if (reference.startsWith("#")) p.query = split(currentUri).query;
    } else {
      path = normalise(p.path || "/");
      const absolute = /^[a-z][a-z\d+.-]*:/i.test(reference);
      if (
        (!logical || absolute) &&
        prefix &&
        (path === prefix || path.startsWith(prefix + "/"))
      )
        path = path.slice(prefix.length) || "/";
    }
    const qs = mergeQuery(p.query, query);
    const hash = fragment === null ? p.fragment : encode(fragment);
    return (
      root +
      "/" +
      path.replace(/^\//, "") +
      (qs ? "?" + qs : "") +
      (hash ? "#" + hash : "")
    );
  };
  return {
    base: root,
    to: (ref, q, f) => build(ref, q, f),
    route: (ref, q, f) => build(ref, q, f, true),
    path: pathFor,
    asset: (ref) => build("assets/" + ref.replace(/^\/+/, ""), {}, null, true),
  };
}

const tools = () =>
  createUrlTools(
    document.querySelector('meta[name="app-url"]')?.content,
    window.location.href,
  );
export const appUrl = (reference = "", query = {}, fragment = null) =>
  tools().to(reference, query, fragment);
export const routeUrl = (route = "", query = {}, fragment = null) =>
  tools().route(route, query, fragment);
export const assetUrl = (path) => tools().asset(path);
export const appPath = () => tools().path(window.location.pathname) || "/";
