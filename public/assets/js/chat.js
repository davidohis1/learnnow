import { api, toast } from "./api.js";
import { routeUrl } from "./url.js";

const root = document.querySelector("#chat-root");
if (root) {
  const feed = document.querySelector("#chat-feed");
  const form = document.querySelector("#chat-form");
  const input = document.querySelector("#chat-input");
  const count = document.querySelector("#chat-count");
  const me = Number(root.dataset.me);
  const canModerate = root.dataset.moderate === "1";
  const icons = { level: "⚡", achievement: "🏅", course: "✅", joined: "👋" };
  let last = Number(root.dataset.last || 0);
  const seen = new Set([...feed.querySelectorAll("[data-id]")].map((n) => n.dataset.id));

  const localTime = (utc) => {
    const d = new Date(String(utc).replace(" ", "T") + "Z");
    return Number.isNaN(d.getTime())
      ? ""
      : d.toLocaleTimeString([], { hour: "numeric", minute: "2-digit" });
  };
  const initials = (name) =>
    String(name || "?").split(/\s+/).filter(Boolean).slice(0, 2).map((p) => p[0].toUpperCase()).join("");
  const nearBottom = () => feed.scrollHeight - feed.scrollTop - feed.clientHeight < 80;
  const el = (tag, cls, text) => {
    const n = document.createElement(tag);
    if (cls) n.className = cls;
    if (text !== undefined) n.textContent = text;
    return n;
  };
  const stamp = (utc) => {
    const t = el("time", "", localTime(utc));
    t.dataset.utc = utc;
    return t;
  };

  function render(m) {
    if (seen.has(String(m.id))) return;
    seen.add(String(m.id));
    last = Math.max(last, Number(m.id));
    feed.querySelector(".chat-placeholder")?.remove();
    let node;
    if (m.kind === "message") {
      node = el("div", "chat-msg" + (Number(m.user_id) === me ? " mine" : ""));
      node.append(el("span", "avatar avatar-small", initials(m.full_name)));
      const bubble = el("div", "chat-bubble");
      const meta = el("div", "chat-meta");
      meta.append(el("strong", "", m.full_name || "Learner"), stamp(m.created_at));
      if (canModerate) {
        const hide = el("button", "chat-hide", "×");
        hide.type = "button";
        hide.dataset.apiButton = routeUrl(`/api/chat/messages/${m.id}/hide`);
        hide.dataset.confirm = "Hide this message for everyone?";
        hide.setAttribute("aria-label", "Hide message");
        meta.append(hide);
      }
      bubble.append(meta, el("p", "", m.body));
      node.append(bubble);
    } else {
      node = el("div", "chat-highlight kind-" + m.kind);
      node.append(el("span", "chat-highlight-icon", icons[m.kind] || "✨"));
      const text = el("span");
      text.append(el("strong", "", m.full_name || "A learner"), document.createTextNode(" " + m.body));
      node.append(text, stamp(m.created_at));
    }
    node.dataset.id = m.id;
    feed.append(node);
  }

  async function poll() {
    if (document.hidden) return;
    try {
      const res = await fetch(`${root.dataset.feedUrl}?after=${last}`, {
        credentials: "same-origin",
        headers: { Accept: "application/json" },
      });
      const data = await res.json();
      if (!res.ok || !data.ok) return;
      const stick = nearBottom();
      data.messages.forEach(render);
      if (count && data.members) count.textContent = data.members;
      if (stick && data.messages.length) feed.scrollTop = feed.scrollHeight;
    } catch {
      /* try again on the next tick */
    }
  }

  feed.querySelectorAll("time[data-utc]").forEach((t) => {
    const v = localTime(t.dataset.utc);
    if (v) t.textContent = v;
  });
  feed.scrollTop = feed.scrollHeight;

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const body = input.value.trim();
    if (!body) return;
    const button = form.querySelector("button");
    button.disabled = true;
    try {
      await api(root.dataset.sendUrl, { body });
      input.value = "";
      await poll();
      feed.scrollTop = feed.scrollHeight;
    } catch (error) {
      toast(error.message, "error");
    } finally {
      button.disabled = false;
      input.focus();
    }
  });

  setInterval(poll, 5000);
  document.addEventListener("visibilitychange", poll);
}
