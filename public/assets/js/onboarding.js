import { api, toast, busy, handleSuccess } from "./api.js";
const wizard = document.querySelector("#onboarding-wizard");
if (wizard) {
  let step = Number(wizard.dataset.step || 0);
  const panels = [...wizard.querySelectorAll("[data-step]")];
  const next = wizard.querySelector("[data-wizard-next]"),
    back = wizard.querySelector("[data-wizard-back]");
  function values() {
    const data = new FormData(wizard);
    const out = {};
    for (const [k, v] of data) if (!k.endsWith("[]")) out[k] = v;
    out.interests = data.getAll("interests[]");
    out.study_days = data.getAll("study_days[]");
    out.reminders_enabled = data.has("reminders_enabled");
    return out;
  }
  function update() {
    panels.forEach((p) => (p.hidden = Number(p.dataset.step) !== step));
    back.hidden = step === 0;
    next.textContent =
      step === 7
        ? "Go to my learning space"
        : step === 0
          ? "Let’s make it yours"
          : "Keep going";
    wizard.querySelector("[data-step-label]").textContent =
      `Step ${step + 1} of 8`;
    wizard.querySelector("[data-wizard-progress]").style.width =
      `${((step + 1) / 8) * 100}%`;
    wizard.querySelectorAll("[data-step-dot]").forEach((p, i) => {
      p.classList.toggle("active", i <= step);
    });
    if (step === 6) {
      const interests = values().interests;
      wizard.querySelectorAll("[data-path-category]").forEach((card) => {
        card.classList.toggle(
          "recommended-option",
          interests.includes(card.dataset.pathCategory),
        );
        const badge = card.querySelector(".recommendation-label");
        if (badge)
          badge.hidden = !interests.includes(card.dataset.pathCategory);
      });
    }
    if (step === 7) {
      const d = values();
      wizard.querySelector("[data-summary-goal]").textContent =
        d.daily_minutes + " minutes of learning credit a day";
      wizard.querySelector("[data-summary-days]").textContent = d.study_days
        .length
        ? d.study_days.length + " study days each week"
        : "A flexible schedule, at your pace";
    }
    const heading = panels[step].querySelector("h1");
    if (heading) {
      heading.tabIndex = -1;
      heading.focus({ preventScroll: true });
    }
  }
  update();
  async function move(direction) {
    const previous = step;
    const d = values();
    if (
      direction > 0 &&
      step === 1 &&
      wizard.querySelector('[name="interests[]"]') &&
      !d.interests.length
    )
      return toast("Choose at least one skill you’re curious about.", "error");
    const desired = Math.min(7, Math.max(0, step + direction));
    busy(next, true);
    back.disabled = true;
    try {
      const result = await api("/api/onboarding", {
        ...d,
        step: desired,
        finish: step === 7 && direction > 0,
      });
      if (result.redirect) return handleSuccess(result);
      step = desired;
      update();
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (error) {
      step = previous;
      toast(error.message, "error");
    } finally {
      busy(next, false);
      back.disabled = false;
      next.textContent =
        step === 7
          ? "Go to my learning space"
          : step === 0
            ? "Let’s make it yours"
            : "Keep going";
    }
  }
  next.addEventListener("click", () => move(1));
  back.addEventListener("click", () => move(-1));
  wizard.addEventListener("submit", (e) => {
    e.preventDefault();
    move(1);
  });
}
