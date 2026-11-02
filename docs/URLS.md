# APP_URL and routing contract

## One authoritative base

`APP_URL` is a complete canonical HTTP(S) URL: scheme, hostname, optional port and optional path prefix. It never comes from `Host`, `X-Forwarded-Host`, `X-Forwarded-Prefix` or JavaScript's `location.origin`. Environment/process configuration takes precedence over the private `.env` file. Missing/invalid configuration fails explicitly.

The base is normalised for trailing/repeated slashes, host/scheme casing, default ports and encoded path segments. Credentials, query strings/fragments in the base, invalid ports, traversal, encoded path separators and control characters are rejected. Internationalised hostnames should be supplied in ASCII/punycode form; Unicode/percent-encoded path segments are supported.

## PHP

All helpers delegate to `app/Helpers/Url.php`:

| Helper | Purpose |
|---|---|
| `route_url('/login')` | A logical application route, always relative to the complete configured base. |
| `url($reference)` | An internal reference that may already be an absolute URL or a prefix-qualified path; idempotent, with no duplicate prefix. |
| `asset_url('css/main.css')` | A public asset under the logical `assets/` namespace. |
| `route_path()` | The current request's logical route, excluding its configured mount and query. |

Both URL builders accept a query array and optional fragment. Query arrays use RFC 3986 encoding; existing repeated query keys are retained unless explicitly replaced. Null query values remove a replaced key. Query-only and fragment-only references resolve against the current in-application request. Fragments used only for same-document navigation may remain `#section`; they are not deployment paths.

**The logical-route/reference distinction is intentional.** If the application itself is mounted at `/admin`, its admin route is `/admin/admin`. `route_url('/admin')` must generate that address, while `url('/admin')` can represent the already-prefixed application root. Guessing between those two meanings cannot be reliable. Route declarations, controller destinations and stored notification links are explicitly logical routes; fully generated DOM/form URLs are internal references.

Escape generated HTML attributes with `e(...)`. External project/resource/YouTube/mailto links are not application routes and are not sent through the internal builder. The builder rejects external redirect targets instead of creating an open redirect. Filesystem paths use `ROOT`/`__DIR__`, not URL helpers.

`success()` converts the designated redirect field into an absolute application URL before producing JSON or a Location response. It does not rewrite arbitrary API payload fields or user content. `redirect()` applies the same service. Verification/reset mail, referral shares and printable certificate links also use it.

## Browser code and assets

The head template emits an escaped, nonsecret `app-url` meta value. `public/assets/js/url.js` reads it and exposes the equivalent `routeUrl`, `appUrl`, `assetUrl` and `appPath` behaviour. The common API wrapper resolves logical endpoints through that service before `fetch()`. Response redirects are validated/normalised before navigation.

ES-module imports are file-relative (`./api.js`, `./url.js`) and font URLs are stylesheet-relative (`../fonts/...`). They inherit the complete URL of the centrally generated parent asset. They contain no root-relative application/deployment path, current hostname or external CDN dependency.

Navigation interception may compare the origin of an already-rendered anchor with the current browser origin to distinguish external navigation. That comparison is not a source of generated application URLs.

## Incoming routes

`public/index.php` validates and removes the configured base path before dispatch. The prefix must match a complete path boundary; `/academy-other` is not a child of `/academy`. Query parameters stay in PHP's original `$_GET`, methods remain intact, and route parameters are raw-URL-decoded once. HEAD shares GET route semantics without a response body. Requests outside the mount and unsafe encoded paths do not match application routes.

Route definitions deliberately stay logical (`/login`, `/api/auth/register`, etc.). No environment prefix is inserted into the route files themselves.

Authentication and CSRF cookies use the configured base path followed by `/`, retaining HttpOnly, SameSite=Lax and the configured Secure flag. Changing a mount/host can require a new sign-in because browsers scope cookies to the old installation; no authentication token is moved into JavaScript storage.

## Apache/static handling

The preferred `public/` document root serves existing whitelisted public assets directly. For prefix forwarding or the optional shared-hosting root bridge, `AssetService` serves only allowed extensions whose real paths stay within `public/assets`. It handles correct MIME types, HEAD, ETags, missing files and invalid methods. It cannot serve configuration, private uploads, logs, dependencies or arbitrary PHP files.

Both `.htaccess` files use relative rewrites and Apache 2.4 `END` flags: no hostname, deployment directory or RewriteBase is embedded. Reverse proxies must preserve the original request URI, including its path prefix. `APP_URL` controls application addresses; it cannot create DNS records or change a provider's physical document-root mapping.

## Stored/emailed links

Notifications store logical route identifiers, not deployment-bound URLs. The view resolves them on read. Migration 007 adds a separate logical link to queued notification mail and converts recognised legacy queued/failed messages. The worker resolves the current URL when actually sending. Already-delivered emails and already-printed certificates cannot be remotely rewritten; preserve redirects/DNS when moving an existing installation if those historic links must continue working.
