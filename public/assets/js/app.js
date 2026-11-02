import { appUrl, routeUrl, appPath } from "./url.js";
import {
  api,
  toast,
  busy,
  confirmAction,
  handleSuccess,
  showFormError,
} from "./api.js";
import "./onboarding.js";
import "./learning.js";
import "./admin.js";
try {
  const message = sessionStorage.getItem("ln_notice");
  if (message) {
    sessionStorage.removeItem("ln_notice");
    toast(message);
  }
} catch {}
document.querySelectorAll("form[data-api]").forEach((form) =>
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    if (form.dataset.saving === "true") return;
    const btn =
      e.submitter || form.querySelector('[type="submit"], button:not([type])');
    const confirmation = btn?.dataset.confirm || form.dataset.confirm;
    if (confirmation && !(await confirmAction(confirmation))) return;
    const password = form.querySelector('[name="password"]'),
      confirmationInput = form.querySelector('[name="password_confirmation"]');
    if (
      password &&
      confirmationInput &&
      password.value !== confirmationInput.value
    ) {
      showFormError(form, new Error("The passwords do not match."));
      return;
    }
    const error = form.querySelector(".form-error");
    if (error) error.textContent = "";
    const data = new FormData(form);
    if (btn?.name) data.set(btn.name, btn.value);
    form.dataset.saving = "true";
    busy(btn, true);
    try {
      const result = await api(form.action, data);
      handleSuccess(result);
      if (form.hasAttribute("data-reset") && !result.redirect && !result.reload)
        form.reset();
    } catch (error) {
      showFormError(form, error);
    } finally {
      form.dataset.saving = "false";
      busy(btn, false);
    }
  }),
);
document.addEventListener("click", async (e) => {
  const action = e.target.closest("[data-api-button]");
  if (action) {
    e.preventDefault();
    if (action.disabled) return;
    if (
      action.dataset.confirm &&
      !(await confirmAction(action.dataset.confirm))
    )
      return;
    let body = {};
    try {
      body = JSON.parse(action.dataset.payload || "{}");
    } catch {}
    busy(action, true);
    try {
      handleSuccess(await api(action.dataset.apiButton, body));
    } catch (error) {
      toast(error.message, "error");
    } finally {
      busy(action, false);
    }
  }
  const passwordToggle = e.target.closest("[data-toggle-password]");
  if (passwordToggle) {
    const input = document.getElementById(
      passwordToggle.dataset.togglePassword,
    );
    if (input) {
      input.type = input.type === "password" ? "text" : "password";
      passwordToggle.setAttribute(
        "aria-label",
        input.type === "password" ? "Show password" : "Hide password",
      );
      passwordToggle.setAttribute(
        "aria-pressed",
        String(input.type === "text"),
      );
    }
  }
  const copy = e.target.closest("[data-copy]");
  if (copy) {
    let text = copy.dataset.copy;
    if (text === "referral")
      text = appUrl(document.querySelector("#referral-link").value);
    try {
      await navigator.clipboard.writeText(text);
      toast("Link copied. Good things are worth sharing.");
    } catch {
      const input = document.querySelector("#referral-link");
      if (input) {
        input.focus();
        input.select();
        toast("Select and copy the link using your device’s copy control.");
      } else toast("Your browser did not allow clipboard access.", "error");
    }
  }
  if (e.target.closest("[data-print]")) window.print();
});
let lastNavTrigger;
function closeNav() {
  document
    .querySelectorAll(".nav-open")
    .forEach((nav) => nav.classList.remove("nav-open"));
  document.body.classList.remove("navigation-open");
  document
    .querySelectorAll("[data-toggle-nav]")
    .forEach((b) => b.setAttribute("aria-expanded", "false"));
  document.querySelectorAll("[data-nav-inert]").forEach((el) => {
    el.inert = false;
    el.removeAttribute("data-nav-inert");
  });
}
document.querySelectorAll("[data-toggle-nav]").forEach((btn) =>
  btn.addEventListener("click", () => {
    const target = document.getElementById(btn.dataset.toggleNav);
    const open = !target.classList.contains("nav-open");
    closeNav();
    if (open) {
      lastNavTrigger = btn;
      target.classList.add("nav-open");
      document.body.classList.add("navigation-open");
      btn.setAttribute("aria-expanded", "true");
      document
        .querySelectorAll(
          target.id === "app-sidebar"
            ? ".app-frame"
            : ".public-body > main,.public-body > footer",
        )
        .forEach((el) => {
          el.inert = true;
          el.setAttribute("data-nav-inert", "");
        });
      target.querySelector("a")?.focus();
    } else lastNavTrigger?.focus();
  }),
);
document.querySelector("[data-close-nav]")?.addEventListener("click", () => {
  closeNav();
  lastNavTrigger?.focus();
});
document
  .querySelectorAll("#public-nav a")
  .forEach((a) => a.addEventListener("click", closeNav));
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape" && document.querySelector(".nav-open")) {
    closeNav();
    lastNavTrigger?.focus();
  }
  if (
    e.key === "/" &&
    !["INPUT", "TEXTAREA", "SELECT"].includes(document.activeElement?.tagName)
  ) {
    const input = document.querySelector(".topbar-search input");
    if (input) {
      e.preventDefault();
      input.focus();
    }
  }
});
const referralInput = document.querySelector("#referral-link");
if (referralInput) referralInput.value = appUrl(referralInput.value);
document.querySelectorAll("[data-browser-notifications]").forEach((btn) =>
  btn.addEventListener("click", async () => {
    if (!("Notification" in window))
      return toast(
        "Browser notifications are not available on this device.",
        "error",
      );
    const permission = await Notification.requestPermission();
    toast(
      permission === "granted"
        ? "Permission granted. In-app notifications remain available in your inbox; background push is not configured."
        : "No problem. Your in-app inbox is always available.",
    );
  }),
);

// Keep keyboard focus inside an open mobile navigation drawer.
document.addEventListener("keydown", (event) => {
  const nav = document.querySelector(".nav-open");
  if (event.key !== "Tab" || !nav) return;
  const focusable = [
    ...nav.querySelectorAll(
      "a[href],button:not([disabled]),input:not([disabled])",
    ),
  ].filter((el) => el.getClientRects().length);
  if (!focusable.length) return;
  const first = focusable[0],
    last = focusable.at(-1);
  if (event.shiftKey && document.activeElement === first) {
    event.preventDefault();
    last.focus();
  } else if (!event.shiftKey && document.activeElement === last) {
    event.preventDefault();
    first.focus();
  }
});
matchMedia("(min-width: 951px)").addEventListener("change", (event) => {
  if (event.matches) closeNav();
});

// Third-party cookie restrictions should not be worked around with insecure cookies.
// Let a learner move an embedded preview into a first-party browser tab instead.
if (
  window.top !== window.self &&
  document.body.classList.contains("auth-body")
) {
  const container = document.querySelector(".auth-content");
  if (container) {
    const notice = document.createElement("div");
    notice.className = "notice info preview-signin-note";
    notice.append(
      document.createTextNode(
        "For secure sign-in, open this preview in its own browser tab. ",
      ),
    );
    const link = document.createElement("a");
    link.href = routeUrl(appPath() + location.search + location.hash);
    link.target = "_blank";
    link.rel = "noopener noreferrer";
    link.textContent = "Open Learnow";
    notice.append(link);
    container.prepend(notice);
  }
}
