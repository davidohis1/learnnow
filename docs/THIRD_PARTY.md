# Third-party components

The application uses no PHP/JavaScript/CSS application framework.

## Runtime libraries

Installed through Composer from the committed lockfile:

- **firebase/php-jwt 7.2.1** — BSD-3-Clause; https://github.com/firebase/php-jwt
- **PHPMailer 6.12.0** — LGPL-2.1-only; https://github.com/PHPMailer/PHPMailer

Composer installs each package's corresponding license files. The portable source archive excludes installed `vendor/` dependencies; run `composer install`. Preserve the original license notices when redistributing dependencies. This document does not grant a license to the project as a whole.

## Local fonts

- **DM Sans** — SIL Open Font License 1.1; full notice in `public/assets/fonts/dmsans-OFL.txt`.
- **Manrope** — SIL Open Font License 1.1; full notice in `public/assets/fonts/manrope-OFL.txt`.

Fonts are self-hosted; normal page rendering does not contact Google Fonts.

## Development/test tools

- **axe-core 4.10.3** — MPL-2.0; pinned test-only script in `tests/tools/axe.min.js`. Original notices are retained. Source: https://github.com/dequelabs/axe-core/tree/v4.10.3 ; license: https://www.mozilla.org/MPL/2.0/ . The script is not served as an application asset.
- Playwright and Requests are optional Python developer dependencies listed in `tests/requirements.txt`.
- PHP_CodeSniffer/PHPCBF and Prettier were used as developer formatters. Neither is a runtime requirement and their tooling caches are excluded from the source deliverable.
