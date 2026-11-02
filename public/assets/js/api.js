import { routeUrl, appUrl } from "./url.js";
export const csrf = () =>
  document.querySelector('meta[name="csrf-token"]')?.content || "";
export async function api(url, body = {}, method = "POST") {
  const isForm = body instanceof FormData;
  const headers = { Accept: "application/json", "X-CSRF-Token": csrf() };
  if (!isForm) headers["Content-Type"] = "application/json";
  let response;
  try {
    response = await fetch(routeUrl(url), {
      method,
      headers,
      credentials: "same-origin",
      body: isForm ? body : JSON.stringify(body),
    });
  } catch {
    throw new Error(
      "We couldn’t reach Learnow. Check your connection and try again.",
    );
  }
  let data;
  try {
    data = await response.json();
  } catch {
    throw new Error(
      "That response was unexpected. Refresh the page and try again.",
    );
  }
  if (!response.ok || !data.ok) {
    const error = new Error(
      data.message || "Something went wrong. Please try again.",
    );
    error.status = response.status;
    error.fields = data.fields;
    throw error;
  }
  return data;
}
export function escapeHtml(value) {
  const el = document.createElement("span");
  el.textContent = String(value ?? "");
  return el.innerHTML.replaceAll('"', "&quot;").replaceAll("'", "&#39;");
}
export function toast(message, type = "success") {
  const region = document.querySelector("#toast-region");
  if (!region) return;
  const el = document.createElement("div");
  el.className = `toast ${type}`;
  el.setAttribute("role", type === "error" ? "alert" : "status");
  el.innerHTML = `<svg class="icon" width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><circle cx="12" cy="12" r="9"/>${type === "error" ? '<path d="M12 7v6m0 3v1"/>' : '<path d="m7 12 3 3 7-7"/>'}</svg><span>${escapeHtml(message)}</span><button type="button" class="icon-button" aria-label="Dismiss notification">×</button>`;
  region.append(el);
  el.querySelector("button").addEventListener("click", () => el.remove());
  setTimeout(() => el.remove(), type === "error" ? 10000 : 6000);
}
export function busy(button, active) {
  if (!button) return;
  if (active) {
    button.dataset.originalHtml = button.innerHTML;
    button.disabled = true;
    button.setAttribute("aria-busy", "true");
    button.innerHTML =
      '<span class="button-spinner" aria-hidden="true"></span> One moment…';
  } else {
    button.disabled = false;
    button.removeAttribute("aria-busy");
    if (button.dataset.originalHtml)
      button.innerHTML = button.dataset.originalHtml;
  }
}
export async function confirmAction(message, title = "One quick check") {
  const dialog = document.querySelector("#confirm-dialog");
  if (!dialog?.showModal) return window.confirm(message);
  dialog.querySelector("#confirm-title").textContent = title;
  dialog.querySelector("#confirm-description").textContent = message;
  return new Promise((resolve) => {
    let finished = false;
    const done = (result) => {
      if (finished) return;
      finished = true;
      dialog.close();
      dialog.removeEventListener("cancel", cancel);
      dialog.querySelector("[data-confirm-cancel]").onclick = null;
      dialog.querySelector("[data-confirm-accept]").onclick = null;
      resolve(result);
    };
    const cancel = (e) => {
      e.preventDefault();
      done(false);
    };
    dialog.addEventListener("cancel", cancel);
    dialog.querySelector("[data-confirm-cancel]").onclick = () => done(false);
    dialog.querySelector("[data-confirm-accept]").onclick = () => done(true);
    dialog.showModal();
    dialog.querySelector("[data-confirm-cancel]").focus();
  });
}
export function handleSuccess(data) {
  if (data.redirect || data.reload) {
    try {
      sessionStorage.setItem("ln_notice", data.message);
    } catch {}
    if (data.redirect) location.assign(appUrl(data.redirect));
    else location.reload();
  } else toast(data.message);
}
export function showFormError(form, error) {
  let box = form.querySelector(".form-error");
  if (!box) {
    box = document.createElement("div");
    box.className = "form-error";
    box.setAttribute("role", "alert");
    form.prepend(box);
  }
  box.textContent = error.message;
  box.tabIndex = -1;
  box.focus({ preventScroll: true });
  box.scrollIntoView({ block: "nearest", behavior: "smooth" });
}
